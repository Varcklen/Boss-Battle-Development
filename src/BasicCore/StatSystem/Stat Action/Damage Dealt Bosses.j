scope DamageDealtBosses initializer init

	private function condition takes nothing returns boolean
		return StatSystem_IsHero(udg_DamageEventSource) and IsUnitType( udg_DamageEventTarget, UNIT_TYPE_ANCIENT) and StatSystem_Get(udg_DamageEventSource, STAT_DAMAGE_DEALT_BOSSES) != 0
	endfunction

	private function action takes nothing returns nothing
		local real multiplier = StatSystem_Get(udg_DamageEventSource, STAT_DAMAGE_DEALT_BOSSES)
		local real damageGain = Event_OnDamageChange_StaticDamage * multiplier
		
        set udg_DamageEventAmount = udg_DamageEventAmount + damageGain
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_OnDamageChange_Real", function action, function condition )
	endfunction

endscope