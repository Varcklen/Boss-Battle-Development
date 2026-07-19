scope AlmightyBeer initializer init

	globals
		private integer ITEM_TYPE = 'IV22'
		
		private integer ITEM_CREATED = 'IV38'
		
		private integer GOLD_GAIN = 2000
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()

		call moneyst(GetManipulatingUnit(), GOLD_GAIN)
		call ItemManipulation_AddItemToHeroOrRestroom(hero, ITEM_CREATED)
		
		set hero = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope