#!/bin/bash
#
# Script automacao de testes utilizando PROBAT do tlppCore
# Generico, precisa receber parametros para funcionar corretamente
#
# Autor: tlppCore
# Date:  2023
#

# 0 (zero) indica retorno sem erro
export nError=0

# ID de execução do script
export ID_EXEC_RUNTESTS=`tr -dc A-Za-z0-9 </dev/urandom | head -c 30`

#----------------------------------------------------------#
# Trata valores de parametros recebidos via linha de comando 
# e padroniza para o correto funcionamento do script
#----------------------------------------------------------#
export COMPILE="YES"
export RUN="YES"
export VERSION="NO"
num=1
for arg in "$@"; do
  a="#$arg"
  a="${a^^}"
  if [[ "${a}" == *"NOCOMPILE"* ]] ; then
    export COMPILE="NO"
  fi
  if [[ "${a}" == *"NORUN"* ]] ; then
    export RUN="NO"
  fi
  if [[ "${a}" == *"VERSION"* ]] ; then
    export VERSION="YES"
    export RUN="BLOCK"
    export COMPILE="BLOCK"
  fi
  ((num++))
done
if [[ "${VERSION}" == "YES" ]] ; then
  echo 'probat command version "01.00.00"'
  exit 0
fi

#----------------------------------------------------------#
# funcao de print da mensagens
#----------------------------------------------------------#
function logMsg() {
  DTTM=`date +"%y/%m/%d %H:%M:%S"`
  echo "${DTTM} [TEST] ${*}"
}

#-------------------------------------------------------------------------------------------#
# funcao de print error da mensagens
#-------------------------------------------------------------------------------------------#
function errorMsg() {
  logMsg [ERROR] $*
}

#-------------------------------------------------------------------------------------------#
# funcao verifica se tem um erro e sai
#-------------------------------------------------------------------------------------------#
function checkError() {
  if [ "${nError}" == "" ]; then
    export nError=34
  fi
  if [ "${nError}" != "0" ]; then
    export nErrorLoc=${nError}
    errorMsg "Error: '${nErrorLoc}'" $*
    exit ${nErrorLoc}
  fi
}

#-------------------------------------------------------------------------------------------#
# check if file exist
#-------------------------------------------------------------------------------------------#
function checkExist() {
  FILE_ORIG="${1}"
  if [ -f "${FILE_ORIG}" ]; then
    logMsg "Generated file: ${FILE_ORIG}"
  else
    export nError=302
    checkError "File '${FILE_ORIG}' not exist or not is a file. curr dir=`pwd`"
  fi
}

#-------------------------------------------------------------------------------------------#
# Executa o PROBAT
#-------------------------------------------------------------------------------------------#
function RUN_TESTS()
{
  EXEC_CMD=${1}
  EXEC_MSG=${2}
  FAIL_ON_RET=${3}

  logMsg ${EXEC_CMD}
  TIME_INI_STR=`date +"%y/%m/%d %H:%M:%S"`
  TIME_INI=`date +"%s"`
  ${EXEC_CMD}
  export nRet=$?
  TIME_END=`date +"%s"`
  TIME_END_STR=`date +"%y/%m/%d %H:%M:%S"`
  TIME_DURAC_SEC=$((TIME_END - TIME_INI))
  logMsg "${EXEC_MSG} ret=${nRet} - ${TIME_INI_STR} - ${TIME_END_STR} (${TIME_DURAC_SEC} sec)"

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

#-------------------------------------------------------------------------------------------#
# INICIA PLANO DE TESTES
#-------------------------------------------------------------------------------------------#
export LOCAL_DIR=$(pwd)
cd "${APP_DIR}"

#-------------------------------------------------------------------------------------------#
# INICIA COMPILACAO
#-------------------------------------------------------------------------------------------#
if [[ "${COMPILE}" != "BLOCK" ]] ; then
  logMsg ""
  logMsg "========================="
  logMsg " ... [START] build project ..."
  if [[ "${COMPILE}" == "YES" ]] ; then
    logMsg "     SRC_DIR: '${SRC_DIR}'"
    logMsg "     APP_DIR: '${APP_DIR}${APP_EXE}'"
    logMsg ""
    export EXEC="./${APP_EXE} "$(echo -console -consolelog -compile -ini=${APP_INI} -files=${SRC_DIR} -includes=${INCLUDES_DIR} -env=${APP_ENV})
    echo "         command -> ${EXEC}"
    ${EXEC}
    export nSysErrEXEC=$?
    export nError=${nSysErrEXEC}
    checkError "Fail compile ${APP_ENV}"
  else
    logMsg ""
    logMsg "User defined by [-nocompile] for sources will not be compiled."
  fi
fi

#-------------------------------------------------------------------------------------------#
# INICIA EXECUCAO DOS TESTES
#-------------------------------------------------------------------------------------------#
if [[ "${RUN}" != "BLOCK" ]] ; then
  logMsg ""
  logMsg "========================="
  logMsg " ... [START] tests by PROBAT ..."
  logMsg ""
  if [[ "${RUN}" == "YES" ]] ; then
    export EXEC="./${APP_EXE} "$(echo -console -consolelog -ini=${APP_INI} -allowexit -run=tlpp.probat.run -env=${APP_ENV} custom:${ID_EXEC_RUNTESTS})
    RUN_TESTS "${EXEC}" "Finish run tests by PROBAT" ""
  else
    logMsg "User defined by [-norun] not to run PROBAT."
  fi
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
