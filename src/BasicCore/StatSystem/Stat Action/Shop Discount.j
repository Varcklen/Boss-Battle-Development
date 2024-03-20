scope ShopDiscount initializer init

	private function condition takes nothing returns boolean
		return StatSystem_Get(ChangeGlobalJuleShopCost.TriggerUnit, STAT_SHOP_DISCOUNT) != BASE_VALUE
	endfunction

	private function action takes nothing returns nothing
		local unit caster = ChangeGlobalJuleShopCost.GetDataUnit("caster")
		local real staticValue = ChangeGlobalJuleShopCost.GetDataReal("static_value")
		local real multiplier = StatSystem_Get(caster, STAT_SHOP_DISCOUNT)
		local real newValue = staticValue * multiplier
		local real currentValue = ChangeGlobalJuleShopCost.GetDataReal("new_value")
		
		call ChangeGlobalJuleShopCost.SetDataReal("new_value", currentValue + newValue )
		
		set caster = null
	endfunction

	private function init takes nothing returns nothing
		//call CreateEventTrigger( "Event_OnHealChange_Real", function action, function condition )
		call ChangeGlobalJuleShopCost.AddListener(function action, function condition)
	endfunction

endscope