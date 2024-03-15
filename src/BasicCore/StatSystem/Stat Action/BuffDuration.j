scope BuffDuration initializer init

	private function condition takes nothing returns boolean
		return StatSystem_IsHero(ChangeBuffDuration.TriggerUnit) and StatSystem_Get(ChangeBuffDuration.TriggerUnit, STAT_BUFF_DURATION) != 0
	endfunction

	private function action takes nothing returns nothing
		local unit caster = ChangeBuffDuration.GetDataUnit("caster")
		local real staticValue = ChangeBuffDuration.GetDataReal("static_value")
		local real multiplier = StatSystem_Get(caster, STAT_BUFF_DURATION)
		local real newValue = staticValue * multiplier
		local real currentValue = ChangeBuffDuration.GetDataReal("new_value")
		
		call ChangeBuffDuration.SetDataReal("new_value", currentValue + newValue )
		
		set caster = null
	endfunction

	private function init takes nothing returns nothing
		//call CreateEventTrigger( "Event_OnHealChange_Real", function action, function condition )
		call ChangeBuffDuration.AddListener(function action, function condition)
	endfunction

endscope