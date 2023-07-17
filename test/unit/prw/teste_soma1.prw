
function U_tstSoma1()

  If U_sum1( 2 ) == 3
    conout( 'OK' )
  Else
    conout( 'Erro' )
  EndIf

  If tlpp.call("tlpp.probat.assertEquals", U_sum1( 2 ), 3 )
    conout( 'OK' )
  Else
    conout( 'Erro' )
  EndIf

  If tlpp.probat.assertEquals( U_sum1( 2 ), 3 )
    conout( 'OK' )
  Else
    conout( 'Erro' )
  EndIf

return
