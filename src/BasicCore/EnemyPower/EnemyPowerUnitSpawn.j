scope EnemyPowerUnitSpawn initializer init

	private function condition takes nothing returns boolean
		return EnemyPower_GetHpBonusAdditive() != 1
	endfunction
	
	private function action takes nothing returns nothing
		local unit unitSummoned = EnemyUnitSummoned.GetDataUnit("unit")
		local real newHP = EnemyPower_ModifyHpValue( BlzGetUnitMaxHP(unitSummoned) )
		local real newAT = EnemyPower_ModifyAtValue( GetUnitDamage(unitSummoned) ) - GetUnitAvgDiceDamage(unitSummoned)
		
        call BlzSetUnitMaxHP( unitSummoned, R2I(newHP) + 1 )
        call BlzSetUnitBaseDamage( unitSummoned, R2I(newAT), 0 )

		if GetUnitAbilityLevel( unitSummoned, 'A1HW') == 0 then
			call SetUnitLifeBJ( unitSummoned, GetUnitStateSwap(UNIT_STATE_MAX_LIFE, unitSummoned) )
		endif
		
		set unitSummoned = null
	endfunction
 
	//===========================================================================
	private function init takes nothing returns nothing
		call EnemyUnitSummoned.AddListener(function action, function condition)
	endfunction
endscope