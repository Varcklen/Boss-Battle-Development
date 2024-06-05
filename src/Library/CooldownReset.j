library CooldownReset requires Inventory

	globals
	    real Event_CooldownReset_Real
	    unit Event_CooldownReset_Hero
	    
	    private boolean LoopSkip = false
	endglobals
	
	// Cброс перезарядки
	private function CooldownStop takes unit u returns nothing
	    local integer unitId =  GetHandleId( u )
		/*if inv( u, 'I0DR') > 0 then
			call SaveBoolean( udg_hash,unitId, StringHash( "wtii" ), false )
		endif*/
	    if inv( u, 'I0DK') > 0 then
	        call SaveBoolean( udg_hash, unitId, StringHash( "orbkm" ), false )
	    endif
	    if inv( u, 'I0ES') > 0 then
	        call SaveBoolean( udg_hash, unitId, StringHash( "orbavh" ), false )
	    endif
	    if inv(u, 'I0ET') > 0 then
	        call SaveBoolean( udg_hash, unitId, StringHash( "orbnt" ), false )
	    endif
	    if inv(u, 'I0F3') > 0 then
	        call SaveBoolean( udg_hash, unitId, StringHash( "orbew" ), false )
	    endif
	    if inv(u, 'I0F5') > 0 then
	        call SaveBoolean( udg_hash, unitId, StringHash( "orbth" ), false )
	    endif
	    if inv(u, 'I0FL') > 0 then
	        call SaveBoolean( udg_hash, unitId, StringHash( "orbcn" ), false )
	    endif
	    if GetUnitAbilityLevel( u, 'A0OE') > 0 then
	        call SaveInteger( udg_hash, unitId, StringHash( "entqch" ), 3 )
	        if GetLocalPlayer() == GetOwningPlayer(u) then
	            call BlzFrameSetText( entQText, I2S(CorruptedEntQ_CHARGE_LIMIT) )
	        endif
	    endif
	    
	    set Event_CooldownReset_Hero = u
	    set Event_CooldownReset_Real = 0.00
	    set Event_CooldownReset_Real = 1.00
	    set Event_CooldownReset_Real = 0.00
	
	    call CooldownReset.SetDataUnit("caster", u)
	    call CooldownReset.Invoke()
	
	    call UnitResetCooldown( u )
	    
	    set u = null
	endfunction
	
	private function OnUnitResetCooldown takes unit target returns nothing
		if LoopSkip then
			return
		endif
		//call BJDebugMsg("Cooldown Stop")
		set LoopSkip = true
		call CooldownStop(target)
		set LoopSkip = false
	endfunction
	
	hook UnitResetCooldown OnUnitResetCooldown

endlibrary