scope LavishMeal initializer init

	globals
		private integer ITEM_TYPE = 'IV26'
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		local player user = GetOwningPlayer(hero)
		
		call SetHeroLevel( hero, GetHeroLevel(hero) + 3, false )
		call Money_AddDebt(user, 750)
		
		set hero = null
		set user = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope