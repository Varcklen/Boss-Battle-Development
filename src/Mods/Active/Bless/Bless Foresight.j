scope BlessForesight initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
		local integer i = 1

        loop
            exitwhen i > 4
            if udg_hero[i] != null then
                call BlzSetUnitRealFieldBJ( udg_hero[i], UNIT_RF_HIT_POINTS_REGENERATION_RATE, BlzGetUnitRealField(udg_hero[i], UNIT_RF_HIT_POINTS_REGENERATION_RATE) + 0.5 )
                call BlzSetUnitRealFieldBJ( udg_hero[i], UNIT_RF_MANA_REGENERATION, BlzGetUnitRealField(udg_hero[i], UNIT_RF_MANA_REGENERATION) + 0.5 )
            endif
            set i = i + 1
        endloop
    endfunction
    
    public function Disable takes nothing returns nothing
		local integer i = 1

        loop
            exitwhen i > 4
            if udg_hero[i] != null then
                call BlzSetUnitRealFieldBJ( udg_hero[i], UNIT_RF_HIT_POINTS_REGENERATION_RATE, BlzGetUnitRealField(udg_hero[i], UNIT_RF_HIT_POINTS_REGENERATION_RATE) - 0.5 )
                call BlzSetUnitRealFieldBJ( udg_hero[i], UNIT_RF_MANA_REGENERATION, BlzGetUnitRealField(udg_hero[i], UNIT_RF_MANA_REGENERATION) - 0.5 )
            endif
            set i = i + 1
        endloop
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope