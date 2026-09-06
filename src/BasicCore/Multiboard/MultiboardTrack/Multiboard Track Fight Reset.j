scope MultiboardTrackFightReset initializer init

	private function condition takes nothing returns boolean
		return IsVictory == false
	endfunction
	
	private function action takes nothing returns nothing
		local integer index = BattleStart.GetDataInteger("index")
		local integer columnPos = Multiboard_GetPlayerColumn(index)

        set udg_DamageFight[index] = 0
        set udg_HealFight[index] = 0
        set udg_ManaFight[index] = 0
        set udg_DamagedFight[index] = 0
        set udg_Info_DamageMagic[index] = 0
        set udg_Info_DamagePhysical[index] = 0
        
        call Multiboard_MultiSetValue( 7, columnPos, "0" )
        call Multiboard_MultiSetValue( 8, columnPos, "0" )
        call Multiboard_MultiSetValue( 10, columnPos, "0" )
        call Multiboard_MultiSetValue( 12, columnPos, "0" )
        call Multiboard_MultiSetValue( 14, columnPos, "0" )
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call BattleStart.AddListener(function action, function condition)
	endfunction
	
endscope