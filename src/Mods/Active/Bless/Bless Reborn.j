scope BlessReborn initializer init

	globals
		private trigger Trigger = null
		
		private constant integer DAMAGE = 300
    	private constant integer RADIUS = 400
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitType( GetDyingUnit(), UNIT_TYPE_HERO)
	endfunction
	
	private function action takes nothing returns nothing
		call GroupAoE( GetDyingUnit(), 0, 0, DAMAGE, RADIUS, "enemy", "Units\\Undead\\Abomination\\AbominationExplosion.mdl", null )
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