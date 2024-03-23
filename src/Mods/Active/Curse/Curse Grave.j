scope CurseGrave initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitType( GetDyingUnit(), UNIT_TYPE_HERO) and not( udg_fightmod[3] ) and combat( GetDyingUnit(), false, 0 )
	endfunction
	
	private function action takes nothing returns nothing
		call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Items\\AIso\\AIsoTarget.mdl", GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ) ) )
    	call SetPlayerState( GetOwningPlayer( GetDyingUnit() ), PLAYER_STATE_RESOURCE_GOLD, IMaxBJ( 0, GetPlayerState( GetOwningPlayer( GetDyingUnit() ), PLAYER_STATE_RESOURCE_GOLD) - 50 ) )
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
		call DisableTrigger( Trigger )
	endfunction

endscope