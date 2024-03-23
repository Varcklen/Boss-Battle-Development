scope CurseSteadfastness initializer init

	globals
		private trigger Trigger = null
		
		private constant real DAMAGE_REDUCTION = -0.05
	endglobals
	
	private function condition takes nothing returns boolean
		return GetOwningPlayer(udg_DamageEventTarget) == Player(10)
	endfunction
	
	private function action takes nothing returns nothing
		local real damageGain = Event_OnDamageChange_StaticDamage * DAMAGE_REDUCTION
	
		set udg_DamageEventAmount = udg_DamageEventAmount + damageGain
	endfunction
	
	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "Event_OnDamageChange_Real", function action, function condition )
		call DisableTrigger( Trigger )
	endfunction

endscope