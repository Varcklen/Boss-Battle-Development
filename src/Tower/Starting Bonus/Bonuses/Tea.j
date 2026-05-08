scope Tea initializer init

	globals
		private integer ITEM_TYPE = 'IV00'
		private integer GOLD_GAIN = 100
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		
		call NewSpecial(hero, udg_DB_Ability_Special[GetRandomInt(1,udg_Database_NumberItems[37])])
		call ItemManipulation_AddItemToHeroOrRestroom(hero, udg_Database_Item_Potion[GetRandomInt(1,udg_Database_NumberItems[9])])
		call moneyst(hero, GOLD_GAIN)
		
		set hero = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope