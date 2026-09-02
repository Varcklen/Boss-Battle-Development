scope Knight5 initializer init
	
	globals
		private constant real EXTRA_DAMAGE = 1

		public trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetUnitTypeId(udg_DamageEventSource) == 'h000' and IsMinion(udg_DamageEventTarget)
	endfunction
	
	private function action takes nothing returns nothing
		set udg_DamageEventAmount = udg_DamageEventAmount + Event_OnDamageChange_StaticDamage * EXTRA_DAMAGE
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = CreateEventTrigger( "Event_OnDamageChange_Real", function action, function condition )
	    call DisableTrigger( Trigger )
	endfunction
	
endscope