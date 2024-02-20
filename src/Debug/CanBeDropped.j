scope CanBeDropped initializer init

	private function condition takes nothing returns boolean
	    return LoadBoolean( udg_hash, GetHandleId(GetManipulatedItem()), StringHash("item_dropped_check") ) == false
	endfunction

	private function Timer takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
		local item droppedItem = LoadItemHandle( udg_hash, id, StringHash("item_set_drop") )
		
		call FlushChildHashtable( udg_hash, id )
		
		if droppedItem == null then
			return
		endif
		call BlzSetItemBooleanFieldBJ( droppedItem, ITEM_BF_CAN_BE_DROPPED, true )
		 
		set droppedItem = null
	endfunction

	private function action takes nothing returns nothing
		local item droppedItem = GetManipulatedItem()

		call BJDebugMsg("item set: " + GetItemName(droppedItem))
	    
	    call SaveBoolean( udg_hash, GetHandleId(droppedItem), StringHash("item_dropped_check"), true )
	    call InvokeTimerWithItem( droppedItem, "item_set_drop", 0.01, false, function Timer )
	    
	    set droppedItem = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger()
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope