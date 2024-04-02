#!/bin/bash
#
# Realiza exports necessarios para executar .\probat_run.sh corretamente
#
# Autor: tlppCore
# Date:  2023
#

# ENV BIN
export ROOT_DIR="/opt/totvs/tlpp-probat-samples/"
export APP_DIR="/opt/totvs/tlpp-probat-samples/bin/appserver/"
export APP_EXE="appsrvlinux"
export APP_ENV="TLPPCORE"
export APP_INI="appserver_sh.ini"
export APP_INI_EXT="appserver_sh_external.ini"

# COMPILE
export SRC_DIR="/opt/totvs/tlpp-probat-samples/src"
export TST_DIR="/opt/totvs/tlpp-probat-samples/test"
export INCLUDES_DIR="/opt/totvs/tlpp-probat-samples/bin/includes"

# RESULTS
export TESTS_RESULT="/opt/totvs/tlpp-probat-samples/bin/appserver/root/system/script_probat_results.xml"
