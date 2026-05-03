scope ColdMilk initializer init

	globals
		private integer ITEM_TYPE = 'IV01'
		private integer ITEM_CREATED = 'I02C'
		private integer CREATION_AMOUNT = 2
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		local integer i = 1
		
		loop
			exitwhen i > CREATION_AMOUNT
			call ItemManipulation_AddItemToHeroOrRestroom(hero, ITEM_CREATED)
			set i = i + 1
		endloop

		set hero = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope