scope MimicExtra initializer init 

	globals
        private constant integer ABILITY_ID = 'A1HA'
    endglobals

	private function AddCrystal takes unit hero, integer valueToAdd returns nothing
	    local integer i = CorrectPlayer(hero)
	    
	    set udg_Set_Cristall_Number[i] = udg_Set_Cristall_Number[i] + valueToAdd
	endfunction
	
	//Enable
    private function Enable takes nothing returns nothing
    	if GetUnitAbilityLevel( Event_HeroChoose_Hero, ABILITY_ID) == 0 then
        	return
        endif
        call AddCrystal(Event_HeroChoose_Hero, 1)
    endfunction
    
    //Disable
    private function Disable takes nothing returns nothing
    	if GetUnitAbilityLevel( Event_HeroRepick_Hero, ABILITY_ID) == 0 then
        	return
        endif
        call AddCrystal(Event_HeroChoose_Hero, -1)
    endfunction

    private function init takes nothing returns nothing
        call CreateEventTrigger( "Event_HeroChoose_Real", function Enable, null )
		call CreateEventTrigger( "Event_HeroRepick_Real", function Disable, null )
    endfunction

endscope