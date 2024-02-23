library Trigger initializer init requires TriggerDatabase

    globals
        private trigger tempTrig = null
    endglobals

    function CreateEventTrigger takes string eventReal, code action, code condition returns trigger
        set tempTrig = CreateTrigger()
        call TriggerRegisterVariableEvent( tempTrig, eventReal, EQUAL, 1.00 )
        if condition != null then
            call TriggerAddCondition( tempTrig, Condition( condition ) )
        endif
        if action != null then
            call TriggerAddAction( tempTrig, action )
        endif
        return tempTrig
    endfunction
    
    globals
    	public unit GlobalEventUnit = null
    
		private constant integer KEY_NAME = StringHash("data_to_save")
		
		private trigger array TriggerToExecute
		private integer array ItemType
		private playerunitevent array EventType
		private string array EventTypeCustom
		private integer ActionListMax = 1
		
		private hashtable ItemTypeData = null
	endglobals

	/*Native Events*/
	private function ExecuteAction takes unit triggerUnit returns nothing
		local integer number
		local integer i = 0
		local integer iMax = UnitInventorySize(triggerUnit)
		local item itemCheck
		local integer index = LoadInteger( udg_hash, GetHandleId(GetTriggeringTrigger()), KEY_NAME )

		loop
			exitwhen i >= iMax
			set itemCheck = UnitItemInSlot( triggerUnit, i )
			set number = LoadInteger( ItemTypeData, GetItemTypeId(itemCheck), KEY_NAME )
			if number != 0 and TriggerDatabase_EventUsed[index] == EventType[number] then
				call ConditionalTriggerExecute( TriggerToExecute[number] )
			endif
			set i = i + 1
		endloop
		
		set triggerUnit = null
		set itemCheck = null
	endfunction
	
	private function ActionUse takes nothing returns nothing
	 	call ExecuteAction(GetTriggerUnit())
	endfunction
	
	function RegisterDuplicatableItemType takes integer itemType, playerunitevent eventToUse, code action, code condition returns nothing
	    local trigger triggerToExecute = CreateTrigger()
	    
	    call TriggerAddAction( triggerToExecute, action )
	    if condition != null then
	    	call TriggerAddCondition( triggerToExecute, Condition( condition ) )
	    endif
	    
	    set TriggerToExecute[ActionListMax] = triggerToExecute
	    set ItemType[ActionListMax] = itemType
	    set EventType[ActionListMax] = eventToUse
	    call SaveInteger( ItemTypeData, itemType, KEY_NAME, ActionListMax )
	    set ActionListMax = ActionListMax + 1
	    
	    set eventToUse = null
	    set action = null
	endfunction
	
	/*Custom Events*/
	private function ExecuteActionCustom takes unit triggerUnit returns nothing
		local integer number
		local integer i = 0
		local integer iMax = UnitInventorySize(triggerUnit)
		local item itemCheck
		local integer index = LoadInteger( udg_hash, GetHandleId(GetTriggeringTrigger()), KEY_NAME )

		loop
			exitwhen i >= iMax
			set itemCheck = UnitItemInSlot( triggerUnit, i )
			set number = LoadInteger( ItemTypeData, GetItemTypeId(itemCheck), KEY_NAME )
			if number != 0 and TriggerDatabase_EventUsedCustom[index] == EventTypeCustom[number] then
				call ConditionalTriggerExecute( TriggerToExecute[number] )
			endif
			set i = i + 1
		endloop
		
		set triggerUnit = null
		set itemCheck = null
	endfunction
	
	private function ActionUseCustom takes nothing returns nothing
	 	call ExecuteActionCustom(GlobalEventUnit)
	endfunction
	
	/*
	* IMPORTANT! Not every custom event has a GlobalEventUnit. Check TriggerCheckList before work with it.
	*/
	function RegisterDuplicatableItemTypeCustom takes integer itemType, string eventToUse, code action, code condition returns nothing
	    local trigger triggerToExecute = CreateTrigger()
	    
	    call TriggerAddAction( triggerToExecute, action )
	    if condition != null then
	    	call TriggerAddCondition( triggerToExecute, Condition( condition ) )
	    endif
	    
	    set TriggerToExecute[ActionListMax] = triggerToExecute
	    set ItemType[ActionListMax] = itemType
	    set EventTypeCustom[ActionListMax] = eventToUse
	    call SaveInteger( ItemTypeData, itemType, KEY_NAME, ActionListMax )
	    set ActionListMax = ActionListMax + 1
	    
	    set eventToUse = null
	    set action = null
	endfunction
	
	private function CreateEvent takes integer index returns nothing
		local trigger trig = CreateTrigger()
		call TriggerRegisterAnyUnitEventBJ( trig, TriggerDatabase_EventUsed[index] )
	    call TriggerAddAction( trig, function ActionUse )
	    call SaveInteger( udg_hash, GetHandleId(trig), KEY_NAME, index )
	endfunction
	
	private function CreateEventCustom takes integer index returns nothing
		local trigger trig = CreateTrigger()
		call TriggerRegisterVariableEvent( trig, TriggerDatabase_EventUsedCustom[index], EQUAL, 1.00 )
		call TriggerAddAction( trig, function ActionUseCustom )
		call SaveInteger( udg_hash, GetHandleId(trig), KEY_NAME, index )
	endfunction
	
	private function CreateEvents takes nothing returns nothing
		local integer i = 1
		
		loop
			exitwhen i >= TriggerDatabase_EventUsed_Max
			call CreateEvent(i)
			set i = i + 1
		endloop
		
		set i = 1
		loop
			exitwhen i >= TriggerDatabase_EventUsedCustom_Max
			call CreateEventCustom(i)
			set i = i + 1
		endloop
	endfunction
	
	private function delay takes nothing returns nothing
		call CreateEvents()
	endfunction
	
	private function init takes nothing returns nothing
    	set ItemTypeData = InitHashtable()
    	call TimerStart( CreateTimer(), 0.5, false, function delay ) 
    endfunction

endlibrary