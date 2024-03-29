scope CheatRandomAbility initializer init

	globals
		trigger trig_CheatRandomAbility = null
	endglobals

	private function Use takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "cheat_cast" ) )
	    local integer abilityType = LoadInteger( udg_hash, id, StringHash( "cheat_cast" ) )
	    local integer abilityIndex = LoadInteger( udg_hash, id, StringHash( "cheat_cast_index" ) ) + 1
	    local trigger trig
	    
	    if abilityType == 0 then
	    	call BJDebugMsg("Q abilities - start")
	    	set trig = udg_DB_Trigger_One[abilityIndex]
	    elseif abilityType == 1 then
	    	call BJDebugMsg("W abilities - start")
	    	set trig = udg_DB_Trigger_Two[abilityIndex]
	    elseif abilityType == 2 then
	    	call BJDebugMsg("R abilities - start")
	    	set trig = udg_DB_Trigger_Three[abilityIndex]
	    else
	    	call BJDebugMsg("END")
	    	call DestroyTimer(GetExpiredTimer( ))
	    	return
	    endif
	    
	    if trig == null then
	    	call SaveInteger( udg_hash, id, StringHash( "cheat_cast" ), abilityType + 1 )
	    	call SaveInteger( udg_hash, id, StringHash( "cheat_cast_index" ), 0 )
	    	return
    	else
    		call SaveInteger( udg_hash, id, StringHash( "cheat_cast_index" ), abilityIndex )
	    endif
	    
	    call CastRandomAbility(caster, 5, trig )
	    
	    set trig = null
	    set caster = null
	endfunction

	private function action takes nothing returns nothing
		call BJDebugMsg("All random abilities used.")
	    
	    call InvokeTimerWithUnit( udg_hero[1], "cheat_cast", 0.5, true, function Use )
	endfunction

	private function init takes nothing returns nothing
	    set trig_CheatRandomAbility = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( trig_CheatRandomAbility, Player(0), "-chaos", false )
	    call TriggerAddAction( trig_CheatRandomAbility, function action )
	endfunction

endscope