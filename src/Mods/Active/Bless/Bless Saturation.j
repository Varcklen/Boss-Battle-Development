scope BlessSaturation initializer init

	
	//===========================================================================
	public function Enable takes nothing returns nothing
		local integer i = 1
        loop
            exitwhen i > 4
            if udg_hero[i] != null then
                call UnitAddAbility( udg_hero[i], 'A0HQ' )
            endif
            set i = i + 1
        endloop
    endfunction
    
    public function Disable takes nothing returns nothing
		local integer i = 1
        loop
            exitwhen i > 4
            if udg_hero[i] != null then
                call UnitRemoveAbility( udg_hero[i], 'A0HQ' )
            endif
            set i = i + 1
        endloop
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope