scope BlessThirst initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitType( GetSpellAbilityUnit(), UNIT_TYPE_HERO)
	endfunction
	
	private function action takes nothing returns nothing
	    call healst( GetSpellAbilityUnit(), null, 20 )
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
        call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
        call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_FINISH, function action, function condition )
		call DisableTrigger( Trigger )
	endfunction

endscope