scope Soulfiend7DamageReduction initializer init
	
	private function condition takes nothing returns boolean
		return GetUnitAbilityLevel( udg_DamageEventTarget, 'B07F' ) > 0
	endfunction

	private function action takes nothing returns nothing
		set udg_DamageEventAmount = udg_DamageEventAmount - Event_OnDamageChange_StaticDamage * 0.65   
	endfunction

	private function init takes nothing returns nothing
	    call CreateEventTrigger( "Event_OnDamageChange_Real", function action, function condition )
	endfunction
	
endscope