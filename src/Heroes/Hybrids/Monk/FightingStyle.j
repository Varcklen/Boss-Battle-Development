scope FightingStyle initializer init

	private function OnBattleEnd_Condition takes nothing returns boolean
		if GetUnitAbilityLevel( BattleEnd.TriggerUnit, 'A0IK' ) > 0 then
			return true
		endif
		if GetUnitAbilityLevel( BattleEnd.TriggerUnit, 'A0IJ' ) > 0 then
			return true
		endif
		if GetUnitAbilityLevel( BattleEnd.TriggerUnit, 'A0IL' ) > 0 then
			return true
		endif
		if GetUnitAbilityLevel( BattleEnd.TriggerUnit, 'A0IM' ) > 0 then
			return true
		endif
		if GetUnitAbilityLevel( BattleEnd.TriggerUnit, 'A0IN' ) > 0 then
			return true
		endif
		if GetUnitAbilityLevel( BattleEnd.TriggerUnit, 'A0IO' ) > 0 then
			return true
		endif
	
		return false
	endfunction
	
	private function OnBattleEnd takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		local integer index = GetPlayerId( GetOwningPlayer( hero ) ) + 1
		local integer spec
		local integer rand
		local integer limit = 0
		
        set spec = udg_Ability_Uniq[index]
        loop
            exitwhen limit > 30
            set rand = GetRandomInt( 1, 3 )
            if udg_DB_Hero_SpecAb[10 + rand] != spec and udg_DB_Hero_SpecAbPlus[10 + rand] != spec then
                call NewUniques( hero, udg_DB_Hero_SpecAb[10 + rand] )
                exitwhen true
            endif
            set limit = limit + 1
        endloop
		
		set hero = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call BattleEnd.AddListener(function OnBattleEnd, function OnBattleEnd_Condition)
	endfunction
	
endscope