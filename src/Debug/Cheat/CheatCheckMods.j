scope CheatCheckMods initializer init

	globals
		public trigger Trigger = null
	endglobals

	private function action takes nothing returns nothing
		local integer i = 1
		local integer iMax = ModeClass_InactiveBlesses.Size
    	local Mode mode
	
		call BJDebugMsg("All blesses enabled.")
	    loop
            exitwhen i > iMax
            set mode = ModeClass_InactiveBlesses.GetIntegerByIndex(0)
            call ModeSystem_Enable(mode)
            set i = i + 1
        endloop
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-blessall", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope