scope CurseScatter initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return GetOwningPlayer(GetDyingUnit()) == Player(10) and GetUnitName(GetDyingUnit()) != "dummy"
	endfunction
	
	private function action takes nothing returns nothing
		call GroupAoE( GetDyingUnit(), 0, 0, 35, 300, "enemy", "war3mapImported\\ArcaneExplosion.mdx", "" )
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
		//set Trigger = AnyHeroDied.AddListener(function action, function condition)
		call DisableTrigger( Trigger )
	endfunction

endscope