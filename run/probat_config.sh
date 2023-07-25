#!/bin/bash
#
# Realiza exports necessarios para executar .\probat_run.sh corretamente
#
# Autor: tlppCore
# Date:  2023
#

# ENV BIN
export APP_DIR="/mnt/d/tlppcore/bin_20.3.1.x/"
export APP_EXE="appserver.exe"
export APP_ENV="TLPPCORE"
export APP_INI="appserver_SH.ini"
export APP_INI_EXT="appserver_SH_external.ini"

# COMPILE
export SRC_DIR="D:\tlppCore_samples\tlpp-probat-samples"
export INCLUDES_DIR="D:\tlppcore\includes;D:\tlppcore\includes_dev;D:\tlppcore\includes_prw"

# RESULTS
export TESTS_RESULT="/mnt/d/tlppcore/bin_20.3.1.x/root/system/scriptProbatResults.xml"
