
main function testRun()

  local cKey := "Hgk34Gnm90-" + strTran( time(), ":", "-" )

  conout( '------------------------------' )
  conout( '      iniciando os testes     ' )
  conout( '------------------------------' )


  // Executa os testes da suite que nao roda em modo ALL
  tlpp.probat.runOffCoverage( "type:suite", "minha_suite_ok", "custom:"+cKey )

  sleep( 2000 )
  
  // Executa todos os testes em modo ALL
  tlpp.probat.run( "custom:"+cKey )

  // Exporta os resultados de todas as execuções acima
  tlpp.probat.export( "type:custom", cKey )

  conout( '------------------------------' )

return
