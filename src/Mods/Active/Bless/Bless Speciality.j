scope BlessSpeciality initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
		local integer i = 1
		
		loop
			exitwhen i > 4
			if udg_hero[i] != null then
				call NewSpecial( udg_hero[i], udg_DB_Ability_Special[GetRandomInt(1, udg_Database_NumberItems[37])] )
			endif
			set i = i + 1
		endloop
    endfunction
    
    public function Disable takes nothing returns nothing

    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope