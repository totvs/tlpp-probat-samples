# Como usar os Scripts

Na pasta RUN, temos os seguintes arquivos relativos aos scripts:<br>
.<br>
..<br>
└── run<br>
    ├── install.sh<br>
    ├── preRun.sh<br>
    └── run.sh<br>

Para seguir com o uso, seguiremos os seguintes passos:

### 1 . Instalação do comando "probat"

Visando facilitar o uso da automação do **PROBAT**, por este projeto disponibilizamos um script que "instala" o comando 'probat' em seu SO linux, também podendo ser utilizado em WSL [Subsistema do Windows para Linux].

Ao baixar esse projeto, através do terminal do Linux ou da janela do WSL no Windows, vá até a pasta onde estão os scripts:

```sh
cd /mnt/d/tlpp-probat-samples/run
```

> É importante que você esteja posicionado no diretório RUN, pois o script utiliza essa pasta para direcionar a execução do script de configuração e execução.

Após entrar na pasta RUN, execute o comando:

```sh
./install.sh
```

Agora você pode utilizar o comando 'probat' de qualquer diretório e em qualquer sessão do terminal ou wsl.

### 2 . Configuração do ambiente

No arquivo [preRun.sh], nós iremos configurar todos os parâmetros de nosso ambiente para o correto funcionamento do script de automação do PROBAT.
Por ele, temos as seguintes variáveis para indicar:

##### APP_DIR

Por ele indicaremos o endereço absoluto do diretório onde se localiza o binário do appServer.

Ex:
```sh
export APP_DIR="/mnt/d/tlppcore/bin_20.3.1.x/"
```

> A sintaxe será igual para ambientes linux ou windows, nesse caso sintaxe padrão UNIX.

##### APP_EXE

Indicamos o nome do executável do AppServer, pois ele pode mudar conforme SO utilizado e customizado em ambientes grandes.

Ex Windows:
```sh
export APP_EXE="appserver.exe"
```

Ex Linux:
```sh
export APP_EXE="appserverlinux"
```

##### APP_ENV

Indicamos o nome do ambiente que será usado para compilação e execução do PROBAT.

Ex:
```sh
export APP_ENV="TLPPCORE"
```

##### APP_INI

Indicamos o nome do arquivo INI de configuração do AppServer, podendo utilizar um INI específico para execução do Script.

```sh
export APP_INI="appserver_SH.ini"
```

##### SRC_DIR

Indicamos o caminho absoluto do diretório que estão localizados os fontes do projeto e de testes para serem compilados.

Ex Windows:
```sh
export SRC_DIR="D:\probat_samples\src"
```

Ex Linux:
```sh
export SRC_DIR="/probat_samples/src"
```

> A sintaxe mudará para ambientes linux (padrão UNIX) ou windows (padrão MSDOS).

##### INCLUDES_DIR

Informamos com o caminho absoluto do(s) diretório(s) onde estão os arquivos de Include (TH ou CH) para uso da compilação dos fontes.

Ex Windows:
```sh
export INCLUDES_DIR="D:\tlppcore\includes;D:\tlppcore\includes_dev"
```

Ex Linux:
```sh
export INCLUDES_DIR="/tlppcore/includes;/tlppcore/includes_dev"
```

> A sintaxe mudará para ambientes linux (padrão UNIX) ou windows (padrão MSDOS).

##### TESTS_RESULT

Informamos com caminho absoluto do arquivo XML que o PROBAT gerará ao final com os resultados da execução.

Ex:
```sh
export TESTS_RESULT="/mnt/d/tlppcore/bin_20.3.1.x/root/system/testsresults.xml"
```

> A sintaxe será igual para ambientes linux ou windows, nesse caso sintaxe padrão UNIX.

### 3 . Configuração do seu ambiente PROBAT

Siga as instruções conforme documentação:
[3 - Configurando](https://tdn.totvs.com/display/tec/3+-+Configurando)
[3c - INI](https://tdn.totvs.com/display/tec/c+-+INI)

### 4 . Execução do comando

Após a instalação do comando [probat] em seu SO ou WSL, configuração do [preRun.sh] e configuração do seu ambiente PROBAT, agora é possível executar o comando e disparar a automação do PROBAT através de seu terminal.

Portanto, temos as seguintes opções:

##### Versão

Ao executar o comando abaixo, obtemos a versão do [probat command] instalado em seu ambiente:

```sh
probat -version
```

##### Compilação

A opção default do comando, é efetuar a compilação dos fontes sempre que executarmos o comando [probat], ou indicarmos de forma explícita que queremos a compilação, sendo:

```sh
probat
```
ou
```sh
probat -compile
```

Caso não queria que a compilação ocorra, então precisa informar ao comando, sendo:

```sh
probat -nocompile
```

##### Execução PROBAT

A opção default do comando, é executar o PROBAT sempre que executarmos o comando [probat], ou indicarmos de forma explícita que queremos a execução dos testes, sendo:

```sh
probat
```
ou
```sh
probat -run
```

Caso não queria que a execução dos testes, então precisa informar ao comando, sendo:

```sh
probat -norun
```

##### Combinando comandos

É possível combinar os comandos, conforme exemplos:

```sh
probat -compile -run
probat -nocompile -run
probat -compile -norun
probat -nocompile -norun
```

A ordem dos parâmetros podem ser mudadas que os efeitos permanecem iguais:

```sh
probat -run -compile
probat -run -nocompile
probat -norun -compile
probat -norun -nocompile
```
