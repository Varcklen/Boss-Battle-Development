scope BasketOfSurprises initializer init

	globals
		private integer ITEM_TYPE = 'IV00'
		private integer ITEMS_TO_CREATE = 3
		
		private real HP_PERCENT_REDUCTION = 0.25
		private real MP_PERCENT_REDUCTION = 0.25
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		local integer i
		local integer itemType

		call BlzSetUnitMaxHP( hero, R2I( BlzGetUnitMaxHP(hero) * (1 - HP_PERCENT_REDUCTION) ) )
		call BlzSetUnitMaxMana( hero, R2I( BlzGetUnitMaxMana(hero) * (1 - MP_PERCENT_REDUCTION) ) )
		set i = 1
		loop
			exitwhen i > ITEMS_TO_CREATE
			set itemType = udg_DB_Gift[GetRandomInt(1, udg_Database_NumberItems[36])]
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