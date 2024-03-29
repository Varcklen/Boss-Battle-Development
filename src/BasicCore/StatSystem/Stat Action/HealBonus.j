scope HealBonus initializer init

	private function condition takes nothing returns boolean
		return StatSystem_IsHero(Event_OnHealChange_Caster) and StatSystem_Get(Event_OnHealChange_Caster, STAT_HEAL_BONUS) != BASE_VALUE
	endfunction

	private function action takes nothing returns nothing
		local real multiplier = StatSystem_Get(Event_OnHealChange_Caster, STAT_HEAL_BONUS)
		local real healGain = Event_OnHealChange_StaticHeal * multiplier
		
		/*call BJDebugMsg("unit: " + GetUnitName(Event_OnHealChange_Caster))
		call BJDebugMsg("old value: " + R2S(healGain))
		call BJDebugMsg("new value: " + R2S(Event_OnHealChange_Heal + healGain))*/
		set Event_OnHealChange_Heal = Event_OnHealChange_Heal + healGain
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_OnHealChange_Real", function action, function condition )
	endfunction

endscope