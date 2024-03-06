scope Test1 initializer init

	private function ReturnItem takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
		local item droppedItem = LoadItemHandle( udg_hash, id, StringHash("item_dropped") )
		local unit user = LoadUnitHandle( udg_hash, id, StringHash("item_dropped_user") )
		
		 call UnitAddItem(user, droppedItem)
		 call FlushChildHashtable( udg_hash, id )
		
		set droppedItem = null
	    set user = null
	endfunction

	private function action takes nothing returns nothing
		local integer id 
		local unit user = GetManipulatingUnit()
		local item droppedItem = GetManipulatedItem()
		
		call BJDebugMsg("unit: " + GetUnitName(user))
		call BJDebugMsg("item: " + GetItemName(droppedItem))
	    
	    set id = InvokeTimerWithItem( droppedItem, "item_dropped", 0.01, false, function ReturnItem )
	    call SaveUnitHandle( udg_hash, id, StringHash("item_dropped_user"), user )
	    
	    set droppedItem = null
	    set user = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger()
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DROP_ITEM )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope