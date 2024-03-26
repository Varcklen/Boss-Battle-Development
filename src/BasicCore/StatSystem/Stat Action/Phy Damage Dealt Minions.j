scope PhyDamageDealtMinions initializer init

	private function condition takes nothing returns boolean
		return udg_IsDamageSpell == false and StatSystem_IsHero(udg_DamageEventSource) and IsMinion(udg_DamageEventTarget) and StatSystem_Get(udg_DamageEventSource, STAT_DAMAGE_DEALT_MINIONS_PHY) != 0
	endfunction

	private function action takes nothing returns nothing
		local real multiplier = StatSystem_Get(udg_DamageEventSource, STAT_DAMAGE_DEALT_MINIONS_PHY)
		local real damageGain = Event_OnDamageChange_StaticDamage * multiplier
		
        set udg_DamageEventAmount = udg_DamageEventAmount + damageGain
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_OnDamageChange_Real", function action, function condition )
	endfunction

endscope