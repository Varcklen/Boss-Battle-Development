scope BlueSky initializer init

globals
	private constant integer REQ = 5
	private constant integer ITEM = 'IZ06'
endglobals

private function conditions takes nothing returns boolean
    return ( IsHeroHasItem( GetSpellAbilityUnit(), ITEM )) and ( combat( GetSpellAbilityUnit(), false, 0 ) )
endfunction

private function actions takes nothing returns nothing
	local unit u = GetSpellAbilityUnit()
    local integer i = 0
    local integer j
    local integer cyclA = 1
    local integer cyclAEnd = udg_Database_NumberItems[24]
    local integer amount = inv( u, ITEM )
    local integer procs
    local integer playerId = GetPlayerId( GetOwningPlayer( u ) ) + 1
    local integer handleId = GetHandleId( u )
    local integer counter = LoadInteger( udg_hash, handleId, StringHash( "az06" ) ) 
    
    set counter = counter + amount //each copy accelerates counter instead of having its own
    set procs = counter / REQ
    //call textst( "|c00FFFF00Procs: " + I2S(procs), u, 64, 90, 15, 1.5 )
    set counter = ModuloInteger(counter, REQ)
    call SaveInteger( udg_hash, handleId, StringHash( "az06" ), counter )
    if counter > 0 then
    	call textst( "|c00FFFF00" + I2S(counter) + "/" + I2S(REQ), u, 64, 90, 15, 1.5 )
    	//call textst( "|c00FFFF00 " + I2S(counter), u, 64, 90, 15, 1.5 )
    endif
    if procs > 0 then
    	set j = CorrectPlayer(u)    
	    loop
	    exitwhen cyclA > cyclAEnd
	    	if udg_DB_Hero_SpecAbAkt[cyclA] == udg_Ability_Uniq[j] or udg_DB_Hero_SpecAbAktPlus[cyclA] == udg_Ability_Uniq[j] then
	        	set i = cyclA
	        	set cyclA = cyclAEnd
    			//call textst( "|c00FFFF00Found: " + I2S(i), u, 64, 90, 15, 1.5 )
	        endif
	        set cyclA = cyclA + 1
	    endloop
	    if i != 0 then
	    	set cyclA = 1
	    	set cyclAEnd = procs
	    	loop
	    	exitwhen cyclA > cyclAEnd
				set udg_RandomLogic = true
	        	set udg_Caster = u
	        	call TriggerExecute( udg_DB_Trigger_Spec[i] )
    			//call textst( "|c00FFFF00Cast!", u, 64, 90, 15, 1.5 )
	        	set cyclA = cyclA + 1
	        endloop
	    endif
    endif
    set u = null
endfunction


//===========================================================================
private function init takes nothing returns nothing
    local trigger trig = CreateTrigger(  )
    //call RegisterDuplicatableItemType(ITEM, EVENT_PLAYER_UNIT_SPELL_EFFECT, function actions, function conditions)
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trig, Condition( function conditions ) )
    call TriggerAddAction( trig, function actions )
    set trig = null
endfunction

endscope