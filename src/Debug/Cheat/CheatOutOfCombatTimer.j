scope CheatOutOfCombatTimer initializer init

	globals
		trigger trig_CheatOutOfCombatTimer = null
	endglobals

	private function action takes nothing returns nothing
	    call BJDebugMsg("Timer Set.")
	    
	    call OutOfCombatTimer_Launch.evaluate(6)
	endfunction

	private function init takes nothing returns nothing
	    set trig_CheatOutOfCombatTimer = CreateTrigger()
	    call DisableTrigger( trig_CheatOutOfCombatTimer )
	    call TriggerRegisterPlayerChatEvent( trig_CheatOutOfCombatTimer, Player(0), "-fast", false )
	    call TriggerAddAction( trig_CheatOutOfCombatTimer, function action )
	endfunction

endscope