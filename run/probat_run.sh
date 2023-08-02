#!/bin/bash
#
# Script central para automacao de testes utilizando PROBAT do tlppCore
#
# Autor: tlppCore
# Date:  2023
#

#----------------------------------------------------------#
# INICIA PLANO DE TESTES
#----------------------------------------------------------#
export LOCAL_DIR=$(pwd)


#----------------------------------------------------------#
# INICIA PLANO DE TESTES
#----------------------------------------------------------#
source ${1}/probat_config.sh
source ${1}/probat_external.sh
source ${1}/probat_functions.sh


export nError=0


#----------------------------------------------------------#
# Trata valores de parametros recebidos via linha de comando 
# e padroniza para o correto funcionamento do script
#----------------------------------------------------------#
export COMPILE="YES"
export RUN="YES"
export VERSION="NO"
export DEBUG="NO"
export PROBAT_EXTERNAL="NO"
num=1
for arg in "$@"; do
  a="$arg"
  a="${a^^}"
  if [[ "${a}" == *"NOCOMPILE"* ]] ; then
    export COMPILE="NO"
  fi
  if [[ "${a}" == *"NORUN"* ]] ; then
    export RUN="NO"
  fi
  if [[ "${a}" == *"-DEBUG"* ]] ; then
    export DEBUG="YES"
  fi
  if [[ "${a}" == *"-EXTERNAL"* ]] ; then
    export PROBAT_EXTERNAL="YES"
  fi
  if [[ "${a}" == *"VERSION"* ]] ; then
    export VERSION="YES"
    export RUN="BLOCK"
    export COMPILE="BLOCK"
  fi
  ((num++))
done
if [[ "${VERSION}" == "YES" ]] ; then
  echo 'probat command version "01.01.00"'
  cd "${LOCAL_DIR}"
  exit 0
fi


#----------------------------------------------------------#
# Validação para saber Plano de execução e
# se irá utilizar a Execução Externa do PROBAT
# (somente sera utilizado no envio de comandos externos)
#----------------------------------------------------------#
if [[ "${RUN}" == "BLOCK" || "${RUN}" == "NO" ]] ; then
  export PROBAT_RUN=0
  export PROBAT_COMPILE=0
else
  export PROBAT_RUN=1
  if [[ "${COMPILE}" == "BLOCK" || "${COMPILE}" == "NO" ]] ; then
    export PROBAT_COMPILE=0
    export PROBAT_PLAN="1:probat_run_Suite_minha_suite_ok 2:probat_run_ALL"
    export STEP_COMP=0
    export STEP_RUN_SUITE=1
    export STEP_RUN_ALL=2
  else
    export PROBAT_COMPILE=1
    export PROBAT_PLAN="1:compilacao 2:probat_run_Suite_minha_suite_ok 3:probat_run_ALL"
    export STEP_COMP=1
    export STEP_RUN_SUITE=2
    export STEP_RUN_ALL=3
  fi
fi


#----------------------------------------------------------#
# INICIA EXECUCOES DOS TESTES
#----------------------------------------------------------#
cd "${APP_DIR}"

# ID de execução do script
export ID_EXEC_RUNTESTS=`tr -dc A-Za-z0-9 </dev/urandom | head -c 30`


startScript
setPlan ${PROBAT_PLAN}


#----------------------------------------------------------#
# Executa o PROBAT
#----------------------------------------------------------#
function RUN_TESTS()
{
  EXEC_CMD=${1}
  EXEC_MSG=${2}
  STEP_RUN=${3}
  STEP_MSG=${4}

  logMsg ${EXEC_CMD}
  TIME_INI_STR=`date +"%y/%m/%d %H:%M:%S"`
  TIME_INI=`date +"%s"`
  ${EXEC_CMD}
  export nRet=$?
  TIME_END=`date +"%s"`
  TIME_END_STR=`date +"%y/%m/%d %H:%M:%S"`
  TIME_DURAC_SEC=$((TIME_END - TIME_INI))
  logMsg "${EXEC_MSG} ret=${nRet} - ${TIME_INI_STR} - ${TIME_END_STR} (${TIME_DURAC_SEC} sec)"

  assertExitCode ${STEP_RUN} ${nRet} command=tlpp.probat.run[${STEP_MSG}]
}

#----------------------------------------------------------#
# Executa o PROBAT
#----------------------------------------------------------#
function EXPORT_RESULTS()
{
  EXEC_CMD=${1}
  EXEC_MSG=${2}

  logMsg ${EXEC_CMD}
  ${EXEC_CMD}
  export nRet=$?
  logMsg "${EXEC_MSG} ret=${nRet}"

  assertExitCode 99 ${nRet} untracked-command=tlpp.probat.export
}

#----------------------------------------------------------#
# Apura Resultado do PROBAT
#----------------------------------------------------------#
function RESULTS_CHECK()
{
  checkExist "${TESTS_RESULT}"
  export RESULTS=`cat ${TESTS_RESULT} | grep "<testsuites"`
  export TESTS=`echo ${RESULTS} | awk '{print $3}'`
  export OK=`echo ${RESULTS} | awk '{print $4}'`
  export FAILURE=`echo ${RESULTS} | awk '{print $5}'`
  export SKIP=`echo ${RESULTS} | awk '{print $6}'`
  logMsg "${RESULTS}"
  logMsg "${TESTS}"
  logMsg "${OK}"
  logMsg "${FAILURE}"
  logMsg "${SKIP}"
}



#----------------------------------------------------------#
# INICIA COMPILACAO
#----------------------------------------------------------#
if [[ "${COMPILE}" != "BLOCK" ]] ; then
  logMsg ""
  logMsg "========================="
  logMsg " ... [START] build project ..."

  #--------#
  # Step 1:Compilacao
  #--------#
  if [[ "${COMPILE}" == "YES" ]] ; then
    
    startStep ${STEP_COMP}

      logMsg "     SRC_DIR: '${SRC_DIR}'"
      logMsg "     APP_DIR: '${APP_DIR}${APP_EXE}'"
      logMsg ""
      export EXEC="./${APP_EXE} "$(echo -console -consolelog -compile -ini=${APP_INI} -files=${SRC_DIR} -includes=${INCLUDES_DIR} -env=${APP_ENV})
      echo "         command -> ${EXEC}"
      ${EXEC}
      export nSysErrEXEC=$?

      assertExitCode ${STEP_COMP} ${nSysErrEXEC} command=compile

      # TODO ler arquivos compilacao
      # fileErrors conter 1 nome # assertError custom:${ID_EXEC_RUNTESTS})

    endStep ${STEP_COMP} ok

    export nError=${nSysErrEXEC}
    checkError "Fail compile ${APP_ENV}"
  else
    logMsg ""
    logMsg "User defined by [-nocompile] for sources will not be compiled."
  fi
fi

#----------------------------------------------------------#
# INICIA EXECUCAO DOS TESTES
#----------------------------------------------------------#
if [[ "${RUN}" != "BLOCK" ]] ; then
  logMsg ""
  logMsg "========================="
  logMsg " ... [START] tests by PROBAT ..."
  logMsg ""

  if [[ "${RUN}" == "YES" ]] ; then

    #--------#
    # Step 2
    # probat.run suite minha_suite_ok
    #--------#

    startStep ${STEP_RUN_SUITE}

      export EXEC="./${APP_EXE} "$(echo -console -consolelog -ini=${APP_INI} -allowexit -run=tlpp.probat.run -env=${APP_ENV} custom:${ID_EXEC_RUNTESTS} type:suite minha_suite_ok) 
      RUN_TESTS "${EXEC}" "Finish run ALL tests by PROBAT" ${STEP_RUN_SUITE} "suite"

    endStep ${STEP_RUN_SUITE} ok


    #--------#
    # Step 3
    # probat.run ALL
    #--------#

    startStep ${STEP_RUN_ALL}

      export EXEC="./${APP_EXE} "$(echo -console -consolelog -ini=${APP_INI} -allowexit -run=tlpp.probat.run -env=${APP_ENV} custom:${ID_EXEC_RUNTESTS})
      RUN_TESTS "${EXEC}" "Finish run ALL tests by PROBAT" ${STEP_RUN_ALL} "all"

    endStep ${STEP_RUN_ALL} ok

  else
    logMsg "User defined by [-norun] not to run PROBAT."
  fi
fi

endScript

# apuracao de resultados
if [[ "${RUN}" == "YES" ]] ; then

  export EXEC="./${APP_EXE} "$(echo -console -consolelog -ini=${APP_INI} -allowexit -run=tlpp.probat.export -env=${APP_ENV} type:custom ${ID_EXEC_RUNTESTS})
  EXPORT_RESULTS "${EXEC}" "Export tests by PROBAT"

  RESULTS_CHECK
fi

#------------------------------------------------------------------------------------------#
# end run tests
#------------------------------------------------------------------------------------------#
logMsg ""
logMsg "--------------------------------------------------------------------------------"
logMsg "--- END RUN - retcod: ${nError} ---"
logMsg "--------------------------------------------------------------------------------"
cd "${LOCAL_DIR}"
exit ${nError}
