scope StickyTrash initializer init

	globals
		private integer ITEM_TYPE = 'IV38'
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function timer_end takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
		local unit hero = LoadUnitHandle( udg_hash, id, StringHash( "sticky_trash" ) )
		local item itemToRemove

		if ItemManipulation_IsInventoryFull(hero) then
			set itemToRemove = UnitItemInSlotBJ(hero, 6)
			if ITEM_TYPE == GetItemTypeId(itemToRemove) then
				return
			endif
			call RemoveItem( itemToRemove )
		endif
		call UnitAddItem(hero, CreateItem(ITEM_TYPE, GetUnitX(hero), GetUnitY(hero)))
		
		set hero = null
		set itemToRemove = null
	endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()

		call InvokeTimerWithUnit( hero, "sticky_trash", 0.1, false, function timer_end )
		
		set hero = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_DROP_ITEM, function action, function condition )
	endfunction

endscope