
function U_samplePRW( nVar1, nVar2 )

  local nSoma := 0

  if ( valtype( nVar1 ) <> "N" )
    nVar1 := 0
  endif

  if ( valtype( nVar2 ) <> "N" )
    nVar2 := 0
  endif

  nSoma := ( nVar1 + nVar2 )

return nSoma
