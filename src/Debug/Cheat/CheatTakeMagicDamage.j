scope CheatTakeMagicDamage initializer init

	globals
		trigger trig_CheatTakeMagicDamage = null
	endglobals

	private function action takes nothing returns nothing
		local real hp = GetUnitState( udg_hero[1], UNIT_STATE_LIFE)
		local real newHp 
		local real damageResult
		call BJDebugMsg("Magic damage taken.")
		set bj_lastCreatedUnit = CreateUnit( Player( 10 ), 'u000', GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]), 270 )
        call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 1)
	    call UnitTakeDamage( bj_lastCreatedUnit, udg_hero[1], 100, DAMAGE_TYPE_MAGIC)
	    
	    set newHp = GetUnitState( udg_hero[1], UNIT_STATE_LIFE)
	    set damageResult = hp - newHp
	    call BJDebugMsg("|cffffcc00Damage Dealed:|r " + R2S(damageResult))
	endfunction

	private function init takes nothing returns nothing
	    set trig_CheatTakeMagicDamage = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( trig_CheatTakeMagicDamage, Player(0), "-take", false )
	    call TriggerAddAction( trig_CheatTakeMagicDamage, function action )
	endfunction

endscope