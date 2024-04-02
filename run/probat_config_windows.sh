#!/bin/bash
#
# Realiza exports necessarios para executar .\probat_run.sh corretamente
#
# Autor: tlppCore
# Date:  2023
#

# ENV BIN
export ROOT_DIR="/mnt/c/tlpp_probat_samples/"
export APP_DIR="/mnt/c/tlpp_probat_samples/bin/appserver/"
export APP_EXE="appserver.exe"
export APP_ENV="TLPPCORE"
export APP_INI="appserver_SH.ini"
export APP_INI_EXT="appserver_SH_external.ini"

# COMPILE
export SRC_DIR="C:\tlpp_probat_samples\src"
export TST_DIR="C:\tlpp_probat_samples\test"
export INCLUDES_DIR="C:\tlpp_probat_samples\bin\includes"

# RESULTS
export TESTS_RESULT="/mnt/c/tlpp_probat_samples/bin/appserver/root/system/script_probat_results.xml"
