# PROBAT
### ( Motor de Testes | tlppCore )

O **PROBAT** é uma ferramenta do tlppCore para a criação e execução de testes em programas TL++ ou ADVPL, apuração de resultados no processo de desenvolvimento ágil, TDD (Test-driven development) e QA (Quality Assurance) de seu projeto.

Esse projeto no GitHub contempla somente exemplos de uso das funcionalidades do **PROBAT**.

Para melhor entendimento desse projeto, recomendamos fortemente a leitura de sua documentação técnica em:
[tdn.totvs.com/display/tec/PROBAT](https://tdn.totvs.com/display/tec/PROBAT)

Para obter a ferramenta oficial, baixe os pacotes em:
[Downloads](https://tdn.totvs.com/display/tec/Downloads)
Sessão: [ *§ PROBAT (Test Engine)* ]

#### INI

Abaixo segue a configuração do appserver.ini para utilizar essa ferramenta e executar esse projeto.

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