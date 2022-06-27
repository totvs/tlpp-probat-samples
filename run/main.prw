
main function testRun()

  local cKey      := "Hgk34Gnm90-" + strTran( time(), ":", "-" )
  local lInstall  := .F.
  local jModule

  conout( '------------------------------' )
  conout( '      iniciando os testes     ' )
  conout( '------------------------------' )

  conout( "#############################################" )
  conout( "Verificando se PROBAT está instalado em seu ambiente" )
  lInstall := tlpp.module( 'PROBAT', @jModule )
  
  if ( lInstall )

		conout( "#############################################" )
    conout( 'Modulo....: ' + jModule['module'] )
		conout( 'Instalado?: ' + if( jModule['linked'], 'sim', 'nï¿½o' ) )
		conout( 'Versão....: ' + jModule['version'] )

    conout( "#############################################" )
    conout( "Iniciando a descoberta dos fontes de testes" )
    tlpp.probat.discovery()

    sleep( 1000 )

    conout( "#############################################" )
    conout( "Executa os testes da suite que não roda em modo ALL" )
    tlpp.probat.runOffCoverage( "type:suite", "minha_suite_ok", "custom:"+cKey )

    sleep( 2000 )

    conout( "#############################################" )
    conout( "Executa todos os testes em modo ALL" )
    tlpp.probat.run( "custom:"+cKey )

    conout( "#############################################" )
    conout( "Exporta os resultados de todas as execuções acima" )
    tlpp.probat.export( "type:custom", cKey )

  else
		conout( "#############################################" )
    conout( ' ## PROBAT não instalado !' )
	endif

  conout( '------------------------------' )

return
