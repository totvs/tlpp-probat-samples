# tlpp-probat-samples

Exemplos de uso da engine de testes **PROBAT** do tlppCore — asserts, suites, cobertura, testes de API REST, integração com banco e automação.

Os fontes em `src/` simulam o código da aplicação; os testes em `test/` usam a sintaxe PROBAT.

## Estrutura do repositório

| Pasta | Conteúdo |
|-------|----------|
| `src/` | Código de exemplo a ser testado (TLPP, AdvPL, API, TDD) |
| `test/probat_resources/` | Asserts, skip, error log e recursos básicos |
| `test/apartness/` | Execução apartada — suite, thread, prioridade |
| `test/api/` | Testes de API REST |
| `test/integration/` | Integração com banco de dados |
| `test/unit/`, `test/tdd/`, `test/coverage/` | Unitários, TDD e cobertura |
| `run/` | Scripts para executar o PROBAT de forma automatizada |
| `ini/` | Configurações do AppServer para os exemplos |

## Documentação

Conceitos, trilha de leitura e mapa dos exemplos:

**https://totvs.github.io/totvstec-doc/docs/tlpp/probat/**
