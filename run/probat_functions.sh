#!/bin/bash
#
# Funções de apoio para o script principal
#
# Autor: tlppCore
# Date:  2023
#

#----------------------------------------------------------#
# funcao de print da mensagens
#----------------------------------------------------------#
function logMsg() {
  DTTM=`date +"%y/%m/%d %H:%M:%S"`
  echo "${DTTM} [TEST] ${*}"
}

#----------------------------------------------------------#
# funcao de print error da mensagens
#----------------------------------------------------------#
function errorMsg() {
  logMsg [ERROR] $*
}

#----------------------------------------------------------#
# funcao de print debug da mensagens
#----------------------------------------------------------#
function debugMsg() {
  if [[ "${DEBUG}" == "YES" ]] ; then
    logMsg [DEBUG] $*
  fi
}

#----------------------------------------------------------#
# funcao verifica se tem um erro e sai
#----------------------------------------------------------#
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

#----------------------------------------------------------#
# check if file exist
#----------------------------------------------------------#
function checkExist() {
  FILE_ORIG="${1}"
  if [ -f "${FILE_ORIG}" ]; then
    logMsg "Generated file: ${FILE_ORIG}"
  else
    export nError=302
    checkError "File '${FILE_ORIG}' not exist or not is a file. curr dir=`pwd`"
  fi
}
