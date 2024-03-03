scope CheatSimulateLeaver initializer init

	globals
		trigger trig_CheatSimulateLeaver = null
	endglobals

	private function action takes nothing returns nothing
	    call BJDebugMsg("Leaver Simulation launched.")
	    
	    call PlayerLeave_Launch(Player(3), true)
	endfunction

	private function init takes nothing returns nothing
	    set trig_CheatOutOfCombatTimer = CreateTrigger()
	    call DisableTrigger( trig_CheatOutOfCombatTimer )
	    call TriggerRegisterPlayerChatEvent( trig_CheatOutOfCombatTimer, Player(0), "-leaver", false )
	    call TriggerAddAction( trig_CheatOutOfCombatTimer, function action )
	endfunction

endscope