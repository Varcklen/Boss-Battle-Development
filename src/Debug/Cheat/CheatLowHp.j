scope CheatLowHp initializer init

	globals
		public trigger Trigger = null
	endglobals

	private function action takes nothing returns nothing
		call BJDebugMsg("Hp set to low.")
		call SetUnitState( udg_hero[1], UNIT_STATE_LIFE, GetUnitState( udg_hero[1], UNIT_STATE_MAX_LIFE) * 0.05)
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-lowhp", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope