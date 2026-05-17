library EnemyPower initializer init requires SpellPower

	globals
		private real HpBonusAdditive = 0
		private real HpBonusMultiplicative = 1
		private real AtBonusAdditive = 0
		private real AtBonusMultiplicative = 1
		
		private constant real BASE_ENEMY_AT_INCREASE = 0.2
		private constant real BASE_ENEMY_HP_INCREASE = 0.35
		
		private constant real HP_REDUCE_PER_PLAYER = 0.2
		private constant real AT_REDUCE_PER_PLAYER = 0.15
		private constant real SP_REDUCE_PER_PLAYER = 0.15
	endglobals
	
	public function ModifyHpValue takes real health returns real
		local real value = ( health + ( health * HpBonusAdditive ) ) * HpBonusMultiplicative
		//call BJDebugMsg("hp: " + R2S(( 1 + ( 1 * HpBonusAdditive ) ) * HpBonusMultiplicative))
		return value
	endfunction
	
	public function ModifyAtValue takes real attack returns real
		local real value = ( attack + ( attack * AtBonusAdditive ) ) * AtBonusMultiplicative
		//call BJDebugMsg("at: " + R2S(( 1 + ( 1 * AtBonusAdditive ) ) * AtBonusMultiplicative))
		return value
	endfunction
	
	public function AddAtBonusAdditive takes real value returns real
		set AtBonusAdditive = AtBonusAdditive + value
		return AtBonusAdditive
	endfunction
	
	public function AddHpBonusAdditive takes real value returns real
		set HpBonusAdditive = HpBonusAdditive + value
		return HpBonusAdditive
	endfunction
	
	public function SetAtBonusAdditive takes real value returns real
		set AtBonusAdditive = value
		return AtBonusAdditive
	endfunction
	
	public function SetHpBonusAdditive takes real value returns real
		set HpBonusAdditive = value
		return HpBonusAdditive
	endfunction
	
	public function GetAtBonusAdditive takes nothing returns real
		return AtBonusAdditive
	endfunction
	
	public function GetHpBonusAdditive takes nothing returns real
		return HpBonusAdditive
	endfunction
	
	//===========================================================================
	private function OnPlayerLeave takes nothing returns nothing
        set HpBonusMultiplicative = HpBonusMultiplicative - HP_REDUCE_PER_PLAYER
        set AtBonusMultiplicative = AtBonusMultiplicative - AT_REDUCE_PER_PLAYER
        call SpellPower_AddBossSpellPower( -SP_REDUCE_PER_PLAYER )
	endfunction
	
    //===========================================================================
    private function ModifyByMissingPlayers takes nothing returns nothing
    	local integer playersMissing = 4 - udg_Heroes_Amount
    	
		set HpBonusMultiplicative = HpBonusMultiplicative - HP_REDUCE_PER_PLAYER * playersMissing
	    set AtBonusMultiplicative = AtBonusMultiplicative - AT_REDUCE_PER_PLAYER * playersMissing
	    call SpellPower_AddBossSpellPower( -SP_REDUCE_PER_PLAYER * playersMissing )
	endfunction
    
    private function init_start takes nothing returns nothing
	    call ModifyByMissingPlayers()
	    
	    /*Base Stat increase*/
	    set HpBonusAdditive = HpBonusAdditive + BASE_ENEMY_HP_INCREASE
	    set AtBonusAdditive = AtBonusAdditive + BASE_ENEMY_AT_INCREASE
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		set gg_trg_Start = CreateTrigger()
	    call TriggerRegisterTimerEvent( gg_trg_Start, 1, false)
	    call TriggerAddAction( gg_trg_Start, function init_start )
	    
	    call CreateEventTrigger( "Event_PlayerLeave_Real", function OnPlayerLeave, null )
	endfunction

endlibrary