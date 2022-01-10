# tlpp-sample-probat
Projeto com exemplos práticos de uso do **PROBAT**, o motor de testes do tlppCore.

> Documentação completa no TDN:
>     [tdn.totvs.com/display/tec/PROBAT](https://tdn.totvs.com/display/tec/PROBAT)

#### INI

Abaixo segue a configuração utilizada em appserver.ini para executar esse projeto.

```ini
[PROBAT]
DEVTLPP=0
SOURCE_DISCOVERY_MODE=0
SOURCE_PATH=D:/tlppCore_samples/tlpp-probat-samples/src
SOURCE_SKIPPED_PATH=probat
TESTS_DISCOVERY_MODE=0
TESTS_DISCOVERY_TIME_INTERVAL=3600
CROSS_VALIDATION=ListFunctionCross
CODECOVERAGE=1
CODECOVERAGE_EXPORT_JSON=1
CODECOVERAGE_PERCENT=60
CODECOVERAGE_EXPORT_TFS=1
CODECOVERAGE_FILTER_SRC=prw,tlpp
EXPORT_FILE_NAME=results
EXPORT_AFTER_RUN=0
EXPORT_FORMAT=JUnit
ShutDown=0
```