scope DifficultyUnitSpawn initializer init

	globals
		public trigger Trigger = null
	endglobals

	private function condition takes nothing returns boolean
		return Difficulty_GetIndex() > 0
	endfunction

	private function action takes nothing returns nothing
		local unit unitUsed = EnemyUnitSummoned.GetDataUnit("unit")
		local integer diffLevel = Difficulty_GetIndex()
        local integer i = 1
	    
	    loop
	        exitwhen i > 4
	        call UnitAddAbility( unitUsed, udg_HardModBonus[i] )
	        call SetUnitAbilityLevel( unitUsed, udg_HardModBonus[i], diffLevel)
	        set i = i + 1
	    endloop
	    
	    call UnitAddAbility( unitUsed, 'A073' )
	    call BlzSetUnitAttackCooldown( unitUsed,BlzGetUnitAttackCooldown( unitUsed,0 ) / HardModAspd[diffLevel],0)
	    
	    set unitUsed = null
	endfunction

	private function init takes nothing returns nothing
		set Trigger = EnemyUnitSummoned.AddListener(function action, null)
		call DisableTrigger(Trigger)
	endfunction

endscope