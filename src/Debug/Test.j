scope Test initializer init
	
	private function action takes nothing returns nothing
		call BJDebugMsg("TEST START")
		call BJDebugMsg("Value: " + R2S(StatSystem_Get(udg_hero[1], STAT_VAMPIRISM_PHY)))
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope