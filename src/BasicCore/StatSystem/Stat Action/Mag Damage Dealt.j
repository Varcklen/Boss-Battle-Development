scope MagDamageDealt initializer init

	private function condition takes nothing returns boolean
		return udg_IsDamageSpell and StatSystem_IsHero(udg_DamageEventSource) and StatSystem_Get(udg_DamageEventSource, STAT_DAMAGE_DEALT_MAG) != BASE_VALUE
	endfunction

	private function action takes nothing returns nothing
		local real multiplier = StatSystem_Get(udg_DamageEventSource, STAT_DAMAGE_DEALT_MAG)
		local real damageGain = Event_OnDamageChange_StaticDamage * multiplier
		
        set udg_DamageEventAmount = udg_DamageEventAmount + damageGain
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_OnDamageChange_Real", function action, function condition )
	endfunction

endscope