scope BentoSet initializer init

	globals
		private integer ITEM_TYPE = 'IV21'
		
		private integer ITEM_CREATED = 'I0B5'
		private integer ITEMS_TO_CREATE = 2
		
		private integer ADDITIONAL_REWARDS = 2
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local integer i
		local integer loopEnd
		local unit hero = GetManipulatingUnit()
		local player user = GetOwningPlayer(hero)
		local item itemToRemove
		local integer playerId = GetPlayerId(GetOwningPlayer(hero))

		call ItemRandomizerLib_AddRewardSelectionOption(user, ADDITIONAL_REWARDS)
		set i = 1
		loop
			exitwhen i > ITEMS_TO_CREATE
			if ItemManipulation_IsInventoryFull(hero) then
				//set isFull = true
				//call BJDebugMsg("ItemManipulation_IsInventoryFull")
				set loopEnd = 0
				loop
					set itemToRemove = UnitItemInSlotBJ(hero, GetRandomInt(1, 6)) //UnitRemoveItemFromSlotSwapped( GetRandomInt(1, 6), hero )
					exitwhen ITEM_CREATED != GetItemTypeId(itemToRemove) or loopEnd > 15
					set loopEnd = loopEnd + 1
				endloop
				call UnitRemoveItemSwapped( itemToRemove, hero )
				call SetItemPositionLoc( itemToRemove, udg_point[22 + playerId] )
			endif
			call UnitAddItem(hero, CreateItem(ITEM_CREATED, GetUnitX(hero), GetUnitY(hero)))
			set i = i + 1
		endloop
		
		set hero = null
		set user = null
		set itemToRemove = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope