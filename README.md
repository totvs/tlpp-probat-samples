# PROBAT - test engine

> [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)<br>Esta é uma iniciativa open source, sob **Licença MIT**, e como tal, é disponibilizada **sem qualquer garantia, expressa ou implícita**, não havendo restrições sobre usar, copiar, modificar, fundir, publicar, distribuir, sublicenciar e/ou vender cópias de seu conteúdo.

> Esse projeto no GitHub contempla somente exemplos de uso das funcionalidades do **PROBAT**.

### O que é o PROBAT?

É um conjunto de ferramentas e funcionalidades nativas do tlppCore para auxiliar os DEVS e equipes no processo de desenvolvimento de software através da criação e execução de testes em programas TLPP ou AdvPL.

### Para que serve?

Melhorar a qualidade do código-fonte em seu projeto de software, possibilitando: 

* Criação e execução de **Testes Unitários**, **Funcionais** e **Integrados**.

* Com a análise de **Resultados** é possível verificar se seu software está cumprindo suas funcionalidades projetadas.

* Através da **Cobertura de Código** é possível verificar se seu plano de testes de fato executa todo o seu código.

* Possibilita o desenvolvimento com **TDD** (Test-driven development).

* Com a utilização de práticas de **DevOps** é possível **Automatizar** a esteira de testes e geração de artefatos.

* Fácil integração com conhecidas ferramentas de **CI/CD**.

* Aprimorar a área de **QA** (Quality Assurance) em seu projeto.


> #### Importante!
> 
> 1 - Para melhor entendimento desse projeto, recomendamos fortemente a leitura de sua documentação técnica em: [tdn.totvs.com/display/tec/PROBAT](https://tdn.totvs.com/display/tec/PROBAT)<br>
> 2 - Recomendamos também assistir ao vídeo [Iniciando no PROBAT](https://www.youtube.com/watch?v=covZWUvXwRA) em nosso canal do Youtube.

### Estrutura do Projeto

O projeto possui a seguinte estrutura de diretórios:<br>
.<br>
..<br>
├── ini<br>
├── run<br>
├── src<br>
└── test<br>

#### [ /ini ]

Na pasta INI temos dois arquivos .ini com configurações do AppServer, um para a subida normal do server e outro para ser utilizado pelo script.

Dentro deles há a configuração do **PROBAT** utilizada.
#### [ /run ]

Na pasta RUN temos todos os scripts necessários para executar o **PROBAT** de forma automatizada.

Os detalhes de como utilizá-los estão em: [Como usar os scripts](scripts.MD)

Além disso, existe o fonte [*main.prw*] mostrando uma outra forma de encadear as execuções, na qual a descoberta dos fontes de testes são apartadas da execução, fazemos uma execução da suite exclusiva e depois a execução de todos os testes. Ao final solicitamos a exportação dos resultados gerados.

#### [ /src ]

Na pasta SRC temos os fontes com a implementação de funcionalidades que serão testadas, fazendo um paralelo à sua realidade, é nessa pasta que estarão os fontes oficiais do seu projeto.

#### [ /test ]

Na pasta TEST temos todas as implementações dos testes com sintaxe para uso do **PROBAT**.
