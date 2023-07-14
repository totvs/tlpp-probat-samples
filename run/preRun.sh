#!/bin/bash
#
# Realiza exports necessarios para executar .\runGeneric.sh
#
# Autor: tlppCore
# Date:  2023
#

# ENV BIN
export APP_DIR="/mnt/d/tlppcore/bin_20.3.1.x/"
export APP_EXE="appserver.exe"
export APP_ENV="TLPPCORE"
export APP_INI="appserver_SH.ini"

# COMPILE
export SRC_DIR="D:\tlppCore_samples\tlpp-probat-samples"
export INCLUDES_DIR="D:\tlppcore\includes;D:\tlppcore\includes_dev;D:\tlppcore\includes_prw"

# RESULTS
export TESTS_RESULT="/mnt/d/tlppcore/bin_20.3.1.x/root/system/scriptProbatResults.xml"

# Executa script principal (NAO MODIFICAR ESSE TRECHO)
export dir_sh="${1}"
export mainSH="${dir_sh}/run.sh"
${mainSH} "$*"