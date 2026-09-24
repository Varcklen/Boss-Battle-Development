scope Soulfiend6 initializer init

	private function condition takes nothing returns boolean
		return udg_IsDamageSpell == false and GetUnitTypeId(udg_DamageEventSource) == 'n04F'
	endfunction

	private function action takes nothing returns nothing
        call BlzSetUnitBaseDamage( udg_DamageEventSource, BlzGetUnitBaseDamage(udg_DamageEventSource, 0) + 5, 0 )
	endfunction

	private function init takes nothing returns nothing
	    call CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	endfunction

endscope
