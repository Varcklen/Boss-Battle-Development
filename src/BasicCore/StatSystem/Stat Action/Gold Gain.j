scope GoldGain initializer init

	private function condition takes nothing returns boolean
		return /*StatSystem_IsHero(Event_OnMoneyChange_Caster) and*/ StatSystem_Get(Event_OnMoneyChange_Caster, STAT_GOLD_GAIN) != BASE_VALUE
	endfunction

	private function action takes nothing returns nothing
		local real multiplier = StatSystem_Get(Event_OnMoneyChange_Caster, STAT_GOLD_GAIN)
		local real goldGain = GetStaticMoney() * multiplier
		
        set Event_OnMoneyChange_Money = Event_OnMoneyChange_Money + goldGain
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_OnMoneyChange_Real", function action, function condition )
	endfunction

endscope