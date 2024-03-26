scope Cooldown initializer init

	private function condition takes nothing returns boolean
		return StatSystem_IsHero(ChangeCooldown.TriggerUnit) and StatSystem_Get(ChangeCooldown.TriggerUnit, STAT_COOLDOWN) != BASE_VALUE
	endfunction

	private function action takes nothing returns nothing
		local unit caster = ChangeCooldown.GetDataUnit("caster")
		local real staticValue = ChangeCooldown.GetDataReal("static_value")
		local real multiplier = StatSystem_Get(caster, STAT_COOLDOWN)
		local real newValue = staticValue * multiplier
		local real currentValue = ChangeCooldown.GetDataReal("new_value")
		
		call ChangeCooldown.SetDataReal("new_value", currentValue + newValue )
		
		set caster = null
	endfunction

	private function init takes nothing returns nothing
		//call CreateEventTrigger( "Event_OnHealChange_Real", function action, function condition )
		call ChangeCooldown.AddListener(function action, function condition)
	endfunction

endscope