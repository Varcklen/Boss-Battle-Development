scope CheatCheckStats initializer init

	globals
		public trigger Trigger = null
	endglobals

	private function action takes nothing returns nothing
		local integer i = 1
		local integer iMax = STAT_AMOUNT
    	local Mode mode
	
		call BJDebugMsg("Stats:")
	    loop
            exitwhen i >= iMax
            call BJDebugMsg("|cffffcc00Stat|r [" + I2S(i) + "]: " + R2S( StatSystem_Get( udg_hero[1], i ) ) )
            set i = i + 1
        endloop
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call DisableTrigger( Trigger )
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-stats", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope