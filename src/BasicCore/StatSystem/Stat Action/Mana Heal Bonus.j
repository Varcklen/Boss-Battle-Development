scope ManaHealBonus initializer init

	private function condition takes nothing returns boolean
		return StatSystem_IsHero(ChangeMagaHealBonus.TriggerUnit) and StatSystem_Get(ChangeMagaHealBonus.TriggerUnit, STAT_MANA_HEAL_BONUS) != 0
	endfunction

	private function action takes nothing returns nothing
		local unit caster = ChangeMagaHealBonus.GetDataUnit("caster")
		local real staticValue = ChangeMagaHealBonus.GetDataReal("static_value")
		local real multiplier = StatSystem_Get(caster, STAT_MANA_HEAL_BONUS)
		local real newValue = staticValue * multiplier
		local real currentValue = ChangeMagaHealBonus.GetDataReal("new_value")
		
		call ChangeMagaHealBonus.SetDataReal("new_value", currentValue + newValue )
		
		set caster = null
	endfunction

	private function init takes nothing returns nothing
		//call CreateEventTrigger( "Event_OnHealChange_Real", function action, function condition )
		call ChangeMagaHealBonus.AddListener(function action, function condition)
	endfunction

endscope