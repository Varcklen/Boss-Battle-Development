scope SetSeed initializer init

	private function condition takes nothing returns boolean
	    return GetTriggerPlayer() == udg_Host
	endfunction
	
	private function action takes nothing returns nothing
		local integer k = S2I(SubString(GetEventPlayerChatString(), 6, 12))
	
		if udg_Boss_LvL > 1 then
			call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 5, "You cannot change the seed after the first battle." )
			return
		endif
		
		call SetRandomSeed(k)
		call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5, "The seed has been successfully changed to " + I2S(k) + "." )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local integer i = 0
	    local trigger trig = CreateTrigger()
	    loop
	        exitwhen i > 3
	        call TriggerRegisterPlayerChatEvent( trig, Player(i), "-seed ", false )
	        set i = i + 1
	    endloop
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )

	    set trig = null
	endfunction

endscope