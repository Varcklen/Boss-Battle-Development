scope CheatHalf initializer init

	globals
		public trigger Trigger = null
	endglobals

	private function action takes nothing returns nothing
		call BJDebugMsg("Stats set to half.")
		call SetUnitState( udg_hero[1], UNIT_STATE_LIFE, GetUnitState( udg_hero[1], UNIT_STATE_MAX_LIFE) * 0.5)
		call SetUnitState( udg_hero[1], UNIT_STATE_MANA, GetUnitState( udg_hero[1], UNIT_STATE_MAX_MANA) * 0.5)
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-half", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope