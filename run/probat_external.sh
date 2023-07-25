#!/bin/bash
#
# Script contendo todos os comandos para enviar eventos do Script
# serem registrados e contabilizados no PROBAT no mesmo ID custom
#
# Oficial DOC: https://tdn.totvs.com/pages/viewpage.action?pageId=778542566
#
# Autor: tlppCore
# Date:  2023
#



#----------------------------------------------------------#
# start / end
#----------------------------------------------------------#

# Start Script
function startScript() {
  if [[ "${PROBAT_RUN}" == "1" ]] ; then
    export EXEC_CMD="./${APP_EXE} "$(echo -ini=${APP_INI_EXT} -run=tlpp.probat.over.startScript -env=${APP_ENV} custom:${ID_EXEC_RUNTESTS})
    debugMsg ${EXEC_CMD}
    ${EXEC_CMD}
  else
    debugMsg "startScript command will not be executed because User defined by [-norun] not to run PROBAT."
  fi
}

# End Script
function endScript() {
  if [[ "${PROBAT_RUN}" == "1" ]] ; then
    export EXEC_CMD="./${APP_EXE} "$(echo -ini=${APP_INI_EXT} -run=tlpp.probat.over.endScript -env=${APP_ENV} custom:${ID_EXEC_RUNTESTS})
    debugMsg ${EXEC_CMD}
    ${EXEC_CMD}
  else
    debugMsg "endScript command will not be executed because User defined by [-norun] not to run PROBAT."
  fi
}



#----------------------------------------------------------#
# Plano de execução
#----------------------------------------------------------#

# Set Plan
function setPlan() {
  if [[ "${PROBAT_RUN}" == "1" ]] ; then
    export EXEC_CMD="./${APP_EXE} "$(echo -ini=${APP_INI_EXT} -run=tlpp.probat.over.setPlan -env=${APP_ENV} custom:${ID_EXEC_RUNTESTS} $*)
    debugMsg ${EXEC_CMD}
    ${EXEC_CMD}
  else
    debugMsg "setPlan command will not be executed because User defined by [-norun] not to run PROBAT."
  fi
}

# Start Step
function startStep() {
  if [[ "${PROBAT_RUN}" == "1" ]] ; then
    export EXEC_CMD="./${APP_EXE} "$(echo -ini=${APP_INI_EXT} -run=tlpp.probat.over.startStep -env=${APP_ENV} custom:${ID_EXEC_RUNTESTS} step:${1})
    debugMsg ${EXEC_CMD}
    ${EXEC_CMD}
  else
    debugMsg "startStep command will not be executed because User defined by [-norun] not to run PROBAT."
  fi
}

# End Step
function endStep() {
  if [[ "${PROBAT_RUN}" == "1" ]] ; then
    export EXEC_CMD="./${APP_EXE} "$(echo -ini=${APP_INI_EXT} -run=tlpp.probat.over.endStep -env=${APP_ENV} custom:${ID_EXEC_RUNTESTS} ${1}:${2})
    debugMsg ${EXEC_CMD}
    ${EXEC_CMD}
  else
    debugMsg "endStep command will not be executed because User defined by [-norun] not to run PROBAT."
  fi
}



#----------------------------------------------------------#
# Asserts
#----------------------------------------------------------#

# Exit Code
function assertExitCode() {
  if [[ "${PROBAT_RUN}" == "1" ]] ; then
    export EXEC_CMD="./${APP_EXE} "$(echo -ini=${APP_INI_EXT} -run=tlpp.probat.over.assertExitCode -env=${APP_ENV} custom:${ID_EXEC_RUNTESTS} step:${1} exitCode:${2} message:${3})
    debugMsg ${EXEC_CMD}
    ${EXEC_CMD}
  else
    debugMsg "assertExitCode command will not be executed because User defined by [-norun] not to run PROBAT."
  fi
}
