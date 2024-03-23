scope BlessHonor initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
		local integer i = 1
		call UnitAddAbility( udg_UNIT_DUMMY_BUFF, 'A0IT' )

        loop
            exitwhen i > 4
            if udg_hero[i] != null then
                call spdst( udg_hero[i], 10 )
            endif
            set i = i + 1
        endloop
    endfunction
    
    public function Disable takes nothing returns nothing
		local integer i = 1
		call UnitRemoveAbility( udg_UNIT_DUMMY_BUFF, 'A0IT' )

        loop
            exitwhen i > 4
            if udg_hero[i] != null then
                call spdst( udg_hero[i], -10 )
            endif
            set i = i + 1
        endloop
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope