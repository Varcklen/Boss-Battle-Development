scope CheatTakeBigMagicDamage initializer init

	globals
		public trigger Trigger = null
	endglobals

	private function action takes nothing returns nothing
		local real hp = GetUnitState( udg_hero[1], UNIT_STATE_LIFE)
		local real newHp 
		local real damageResult
		call BJDebugMsg("Magic damage taken.")
		set bj_lastCreatedUnit = CreateUnit( Player( 10 ), 'u000', GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]), 270 )
        call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 1)
	    call UnitTakeDamage( bj_lastCreatedUnit, udg_hero[1], 1000, DAMAGE_TYPE_MAGIC)
	    
	    set newHp = GetUnitState( udg_hero[1], UNIT_STATE_LIFE)
	    set damageResult = hp - newHp
	    call BJDebugMsg("|cffffcc00Damage Dealed:|r " + R2S(damageResult))
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-takeb", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope