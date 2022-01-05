
main function testRun()

  local cKey      := "Hgk34Gnm90-" + strTran( time(), ":", "-" )
  local lInstall  := .F.
  local jModule


  conout( '------------------------------' )
  conout( '      iniciando os testes     ' )
  conout( '------------------------------' )

  // Verificando se PROBAT está instalado em seu ambiente
  lInstall := tlpp.module( 'PROBAT', @jModule )
  
  if ( lInstall )

		conout( 'Modulo....: ' + jModule['module'] )
		conout( 'Instalado?: ' + if( jModule['linked'], 'sim', 'não' ) )
		conout( 'Versão....: ' + jModule['version'] )

    // Executa os testes da suite que nao roda em modo ALL
    tlpp.probat.runOffCoverage( "type:suite", "minha_suite_ok", "custom:"+cKey )

    sleep( 2000 )
    
    // Executa todos os testes em modo ALL
    tlpp.probat.run( "custom:"+cKey )

    // Exporta os resultados de todas as execuções acima
    tlpp.probat.export( "type:custom", cKey )

  else
		conout( ' ## PROBAT nao instalado !' )
	endif

  conout( '------------------------------' )

return
