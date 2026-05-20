scope PathOfTheRune initializer init

	globals
		private constant integer BUFF_CHECK = 'B0B1'
		private constant integer TAG_CHECK = 'A1I2'
		
		private constant integer EFFECT_ID = 'A1I3'
		private constant integer BUFF_ID = 'B0B2'
		private constant integer DURATION = 10
	endglobals

	private function condition takes nothing returns boolean
		return GetUnitAbilityLevel(GetManipulatingUnit(), BUFF_CHECK) > 0 and BlzGetItemAbility( GetManipulatedItem(), TAG_CHECK ) != null 
	endfunction

	private function action takes nothing returns nothing
		call bufst( GetManipulatingUnit(), GetManipulatingUnit(), EFFECT_ID, BUFF_ID, "path_of_the_rune", DURATION ) 
	endfunction
	
	//===========================================================================
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT_ID) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        local unit hero = Event_DeleteBuff_Unit

        call UnitRemoveAbility( hero, EFFECT_ID )
        call UnitRemoveAbility( hero, BUFF_ID )
        
        set hero = null
    endfunction
	
	//===============================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	    call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
	endfunction

endscope