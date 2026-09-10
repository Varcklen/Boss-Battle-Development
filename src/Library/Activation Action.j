library ActivationAction requires Inventory

	function eyest takes unit u returns integer
	    local integer k = 1
	    local integer s
	    local integer i = GetPlayerId(GetOwningPlayer( u ) ) + 1
	    local integer id

	    call ItemUsed.SetDataUnit("caster", u)
	    call ItemUsed.SetDataInteger("amount_of_uses", k)
	    call ItemUsed.Invoke()
	    
	    set k = ItemUsed.GetDataInteger("amount_of_uses")
	    
	    if GetUnitAbilityLevel( u, 'B06M') > 0 then
	        set k = k * 3
	        call UnitRemoveAbility( u, 'A0PN' )
	        call UnitRemoveAbility( u, 'B06M' )
	    elseif GetUnitAbilityLevel( u, 'B032') > 0 then
	        set k = k * 2
	    endif
	    if GetUnitAbilityLevel( u, 'A054' ) > 0 and inv( u, 'I040' ) == 0 then
	        call UnitRemoveAbility( u, 'A054' )
	        call UnitRemoveAbility( u, 'B032' )
	    endif
	    set u = null
	    return k
	endfunction

endlibrary