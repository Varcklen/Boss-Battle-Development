scope FreshWater initializer init

	globals
		private integer ITEM_TYPE = 'I0HU'
		private integer GOLD_DISCOUNT = 100
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		local player user = GetOwningPlayer(hero)
		local integer index = GetPlayerId( user ) + 1
		
		set udg_rollbase[index] = udg_rollbase[index] + 1
		call BaseTooltip_AddRefreshCost( user, -GOLD_DISCOUNT )
		
		set hero = null
		set user = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope