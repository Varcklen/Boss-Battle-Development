library ItemEffectTemplate

	
	
	/*//! textmacro ItemEffect takes ITEMTYPE, EVENTTYPE, CONDITIONTYPE 
    private function ItemEffectCondition takes nothing returns boolean
        return GetItemTypeId(GetManipulatedItem()) == $ITEMTYPE$
    endfunction

	private function Add takes nothing returns nothing
	    local item usedItem = GetManipulatedItem()
	    local unit owner = GetManipulatingUnit()
	    local trigger trig = CreateTrigger()
	    
	    call TriggerRegisterUnitEvent( trig, owner, $EVENTTYPE$ )
	    call TriggerAddAction( trig, function action )
	    if $CONDITIONTYPE$ != null then
	    	call TriggerAddCondition( trig, Condition( $CONDITIONTYPE$ ) )
	    endif
	    call SaveTriggerHandle( udg_hash, GetHandleId(usedItem), KEY_NAME, trig )
	    
	    set usedItem = null
	    set owner = null
	    set trig = null
	endfunction
	
	private function Remove takes nothing returns nothing
	    local item usedItem = GetManipulatedItem()
	    local integer id = GetHandleId(usedItem)
	    local trigger trig = LoadTriggerHandle( udg_hash, id, KEY_NAME )
	    
	    call DestroyTrigger(trig)
	    call RemoveSavedHandle( udg_hash, id, KEY_NAME )
	    
	    set usedItem = null
	    set trig = null
	endfunction
	
	//===========================================================================
	private function InitTrigger takes nothing returns nothing
	    local trigger trig = CreateTrigger()
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	    call TriggerAddCondition( trig, Condition( function ItemEffectCondition ) )
	    call TriggerAddAction( trig, function Add )
	    
	    set trig = CreateTrigger()
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DROP_ITEM )
	    call TriggerAddCondition( trig, Condition( function ItemEffectCondition ) )
	    call TriggerAddAction( trig, function Remove )
	    
	    set trig = null
	endfunction
    //! endtextmacro*/

endlibrary