scope CheatTakeMagicDamage initializer init

	globals
		trigger trig_CheatTakeMagicDamage = null
	endglobals

	private function action takes nothing returns nothing
		call BJDebugMsg("Magic damage taken.")
	    call UnitTakeDamage( udg_hero[1], udg_hero[1], 100, DAMAGE_TYPE_MAGIC)
	endfunction

	private function init takes nothing returns nothing
	    set trig_CheatTakeMagicDamage = CreateTrigger()
	    call DisableTrigger( trig_CheatTakeMagicDamage )
	    call TriggerRegisterPlayerChatEvent( trig_CheatTakeMagicDamage, Player(0), "-take", false )
	    call TriggerAddAction( trig_CheatTakeMagicDamage, function action )
	endfunction

endscope