scope DamageTakenFromMinions initializer init

	private function condition takes nothing returns boolean
		return StatSystem_IsHero(udg_DamageEventTarget) and IsUnitType( udg_DamageEventSource, UNIT_TYPE_HERO) == false and IsUnitType( udg_DamageEventSource, UNIT_TYPE_ANCIENT) == false and StatSystem_Get(udg_DamageEventTarget, STAT_DAMAGE_TAKEN_FROM_MINIONS) != BASE_VALUE
	endfunction

	private function action takes nothing returns nothing
		local real multiplier = StatSystem_Get(udg_DamageEventTarget, STAT_DAMAGE_TAKEN_FROM_MINIONS)
		local real damageGain = Event_OnDamageChange_StaticDamage * multiplier
		
        set udg_DamageEventAmount = udg_DamageEventAmount + damageGain
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_OnDamageChange_Real", function action, function condition )
	endfunction

endscope