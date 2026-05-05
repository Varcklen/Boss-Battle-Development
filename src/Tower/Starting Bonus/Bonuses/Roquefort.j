scope Roquefort initializer init

	globals
		private integer ITEM_TYPE = 'IV01'
		
		private integer ITEM_CREATED_1 = 'I0B5'
		private integer ITEM_CREATED_2 = 'I01U'
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local integer loopEnd
		local unit hero = GetManipulatingUnit()
		local player user = GetOwningPlayer(hero)
		local item itemToRemove
		local integer playerId = GetPlayerId(GetOwningPlayer(hero))

		if ItemManipulation_IsInventoryFull(hero) then

			set loopEnd = 0
			loop
				set itemToRemove = UnitItemInSlotBJ(hero, GetRandomInt(1, 6))
				exitwhen ITEM_CREATED_1 != GetItemTypeId(itemToRemove) or loopEnd > 15
				set loopEnd = loopEnd + 1
			endloop
			call UnitRemoveItemSwapped( itemToRemove, hero )
			call SetItemPositionLoc( itemToRemove, udg_point[22 + playerId] )
		endif
		call UnitAddItem(hero, CreateItem(ITEM_CREATED_1, GetUnitX(hero), GetUnitY(hero)))
		call ItemManipulation_AddItemToHeroOrRestroom(hero, ITEM_CREATED_2)
		
		set hero = null
		set user = null
		set itemToRemove = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope