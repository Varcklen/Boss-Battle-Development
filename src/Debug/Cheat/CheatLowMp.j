scope CheatLowMp initializer init

	globals
		public trigger Trigger = null
	endglobals

	private function action takes nothing returns nothing
		call BJDebugMsg("Mp set to low.")
		call SetUnitState( udg_hero[1], UNIT_STATE_MANA, GetUnitState( udg_hero[1], UNIT_STATE_MAX_MANA) * 0.05)
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-lowmp", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope