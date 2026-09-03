scope DifficultyUnitSpawn initializer init

	globals
		public trigger Trigger = null
		
		private constant integer DIFFICULTY_STAT_IGNORE_ABILITY = 'A1IG'
	endglobals

	private function condition takes nothing returns boolean
		return /*Difficulty_GetIndex() > 0 and*/ GetUnitAbilityLevel( EnemyUnitSummoned.GetDataUnit("unit"), DIFFICULTY_STAT_IGNORE_ABILITY ) == 0 
	endfunction

	private function action takes nothing returns nothing
		local unit unitUsed = EnemyUnitSummoned.GetDataUnit("unit")
		local integer diffLevel = Difficulty_GetIndex()
        local integer i = 1
        local real value
	    
	    loop
	        exitwhen i > 4
	        call UnitAddAbility( unitUsed, udg_HardModBonus[i] )
	        call SetUnitAbilityLevel( unitUsed, udg_HardModBonus[i], diffLevel)
	        set i = i + 1
	    endloop
	    
	    call UnitAddAbility( unitUsed, 'A073' )
	    
	    set value = BlzGetUnitAttackCooldown( unitUsed,0 ) / HardModAspd[diffLevel]
	    call BlzSetUnitAttackCooldown( unitUsed, value,0)
	    
	    set value = BlzGetUnitBaseDamage(unitUsed, 0) * Difficulty_ATTACK_DAMAGE_BONUS[diffLevel]
	    call BlzSetUnitBaseDamage( unitUsed, R2I( value ), 0 )
	    
	    set unitUsed = null
	endfunction

	private function init takes nothing returns nothing
		set Trigger = EnemyUnitSummoned.AddListener(function action, function condition)
		call DisableTrigger(Trigger)
	endfunction

endscope