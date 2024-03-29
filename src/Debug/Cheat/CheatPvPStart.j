scope CheatPvPStart initializer init

	globals
		trigger CheatPvPStart = null
	endglobals

	private function action takes nothing returns nothing
	    call BJDebugMsg("PvP started.")
	    call PAStart_BattleStart.evaluate(1, 2)
	endfunction

	private function init takes nothing returns nothing
	    set CheatPvPStart = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( CheatPvPStart, Player(0), "-pvp", false )
	    call TriggerAddAction( CheatPvPStart, function action )
	endfunction

endscope