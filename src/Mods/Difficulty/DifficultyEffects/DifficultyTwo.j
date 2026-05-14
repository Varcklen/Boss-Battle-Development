scope DifficultyTwo initializer init

	globals
		private integer DIFFICULTY_REQUIRED = 2
		private boolean isActive = false
		
		private real HP_LOSS = 0.35
		private real MP_LOSS = 0.35
		
		private trigger Trigger = null
	endglobals
	
	private function OnBattleStart_Condition takes nothing returns boolean
	    return udg_fightmod[3] == false
	endfunction

	private function OnBattleStart takes nothing returns nothing
	    local unit hero = BattleStart.GetDataUnit("caster")
	    
	    call SetUnitState( hero, UNIT_STATE_LIFE, GetUnitState( hero, UNIT_STATE_LIFE) - (GetUnitState( hero, UNIT_STATE_MAX_LIFE) * HP_LOSS) )
        call SetUnitState( hero, UNIT_STATE_MANA, GetUnitState( hero, UNIT_STATE_MANA) - (GetUnitState( hero, UNIT_STATE_MAX_MANA) * MP_LOSS) )
	    
	    set hero = null
	endfunction

	//===============================================================
	private function condition takes nothing returns boolean
	    return isActive == false and Difficulty_GetIndex() >= DIFFICULTY_REQUIRED
	endfunction

	private function action takes nothing returns nothing
	    call EnableTrigger(Trigger)
	    set isActive = true
	endfunction

	private function init takes nothing returns nothing
	    call OnModsAwake.AddListener(function action, function condition)
	    
	    set Trigger = BattleStart.AddListener(function OnBattleStart, function OnBattleStart_Condition)
	    call DisableTrigger(Trigger)
	endfunction

endscope