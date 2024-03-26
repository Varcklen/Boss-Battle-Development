scope Test initializer init
	
	private function action takes nothing returns nothing
		local Mode mode = ModeSystem_GetRandomBless(false)
		
		call BJDebugMsg("mode: " + BlzGetAbilityTooltip(mode.Info, 0))
	
		call ModeSystem_Enable(mode)
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope