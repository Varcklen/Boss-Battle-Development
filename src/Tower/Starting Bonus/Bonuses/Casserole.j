scope Casserole initializer init

	globals
		private integer ITEM_TYPE = 'IV20'
		
		private integer ITEMS_TO_CREATE = 2
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local integer i
		local unit hero = GetManipulatingUnit()
		local integer itemType

		set i = 1
		loop
			exitwhen i > ITEMS_TO_CREATE
			set itemType = ItemRandomizerLib_GetRandomExileItemType()
			call ItemManipulation_AddItemToHeroOrRestroom(hero, itemType)
			set i = i + 1
		endloop
		
		
		set hero = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope