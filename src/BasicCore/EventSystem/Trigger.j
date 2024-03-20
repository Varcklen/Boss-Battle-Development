library Trigger initializer init requires EventDatabase

    globals
        private trigger tempTrig = null
    endglobals

	/*OBSOLETE. USE EVENT SYSTEM*/
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
    /*===========================*/
    
    function CreateNativeEvent takes playerunitevent eventId, code action, code condition returns trigger
        set tempTrig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( tempTrig, eventId )
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
    
    	private constant string KEY_NAME_STRING = "data_to_save"
		private constant integer KEY_NAME = StringHash(KEY_NAME_STRING + "1")
		private constant integer EVENT_AMOUNT = StringHash("event_amount")
		
		private trigger array TriggerToExecute
		private integer array ItemType
		private playerunitevent array EventType
		private Event array EventTypeCustom
		private integer ActionListMax = 1
		
		private hashtable ItemTypeData = null
		private item ItemUsed = null
	endglobals
	
	public function GetItemUsed takes nothing returns item
		return ItemUsed
	endfunction

	/*Base Events*/
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
			if number != 0 and EventDatabase_EventUsed[index] == EventType[number] then
				set ItemUsed = itemCheck
				call ConditionalTriggerExecute( TriggerToExecute[number] )
			endif
			set i = i + 1
		endloop
		set ItemUsed = null
		
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
	    
	    set triggerToExecute = null
	endfunction
	
	private function CreateEvent takes integer index returns nothing
		local trigger trig = CreateTrigger()
		call TriggerRegisterAnyUnitEventBJ( trig, EventDatabase_EventUsed[index] )
	    call TriggerAddAction( trig, function ActionUse )
	    call SaveInteger( udg_hash, GetHandleId(trig), KEY_NAME, index )
	    set trig = null
	endfunction
	
	/*Custom Events*/
	private function LaunchTrigger takes integer index, integer itemType, integer stringNumber, item itemCheck returns nothing
		local integer number = LoadInteger( ItemTypeData, itemType, StringHash(KEY_NAME_STRING) + stringNumber )
		
		if number == 0 then
			return
		endif
		
		if EventSystem_EventUsedCustom[index] != EventTypeCustom[number] then
			return
		endif
		
		set ItemUsed = itemCheck
		call ConditionalTriggerExecute( TriggerToExecute[number] )
	endfunction
	
	private function NumberCheck takes integer index, item itemCheck returns nothing
		local integer itemType = GetItemTypeId(itemCheck)
		local integer amountOfEvents = LoadInteger(ItemTypeData, itemType, EVENT_AMOUNT)
		local integer i
		
 		if amountOfEvents == 1 then
			call LaunchTrigger(index, itemType, amountOfEvents, itemCheck)
		else
			set i = 1
			loop
				exitwhen i > amountOfEvents
				call LaunchTrigger(index, itemType, i, itemCheck)
				set i = i + 1
			endloop
		endif
	endfunction
	
	private function Launch takes unit triggerUnit, integer index returns nothing
		local integer i
		local integer iMax
		local integer number
		local item itemCheck
		
		if IsUnitType( triggerUnit, UNIT_TYPE_HERO) == false then
			return
		endif
	
		set i = 0
		set iMax = UnitInventorySize(triggerUnit)
		loop
			exitwhen i >= iMax
			set itemCheck = UnitItemInSlot( triggerUnit, i )
			call NumberCheck(index, itemCheck)
			set i = i + 1
		endloop
		set itemCheck = null
	endfunction
	
	private function ExecuteActionCustom takes nothing returns nothing
		local Event currentEvent = Event.Current
		local integer index = LoadInteger( udg_hash, GetHandleId(GetTriggeringTrigger()), KEY_NAME )

		/*TriggerUnit*/
		call Launch(currentEvent.TriggerUnit, index)
		/*TargetUnit*/
		if currentEvent.TargetUnit != currentEvent.TriggerUnit then
			call Launch(currentEvent.TargetUnit, index)
		endif
		
		set ItemUsed = null
	endfunction
	
	function RegisterDuplicatableItemTypeCustom takes integer itemType, Event eventType, code action, code condition returns nothing
	    local trigger triggerToExecute = CreateTrigger()
	    local integer amountOfEvents = LoadInteger(ItemTypeData, itemType, EVENT_AMOUNT) + 1
	    local integer stringHash
	    
	    call TriggerAddAction( triggerToExecute, action )
	    if condition != null then
	    	call TriggerAddCondition( triggerToExecute, Condition( condition ) )
	    endif
	    
	    set TriggerToExecute[ActionListMax] = triggerToExecute
	    set ItemType[ActionListMax] = itemType
	    set EventTypeCustom[ActionListMax] = eventType
	    
	    call SaveInteger( ItemTypeData, itemType, KEY_NAME, ActionListMax )
	    
	    set stringHash = StringHash(KEY_NAME_STRING) + amountOfEvents
	    call SaveInteger( ItemTypeData, itemType, stringHash, ActionListMax )
	    
	    set ActionListMax = ActionListMax + 1
	    
	    call SaveInteger(ItemTypeData, itemType, EVENT_AMOUNT, amountOfEvents )
	    
		set triggerToExecute = null
	endfunction
	
	private function CreateEventCustom takes integer index returns nothing
		local Event eventUsed = EventSystem_EventUsedCustom[index]
		local trigger trig = eventUsed.AddListener(function ExecuteActionCustom, null)
		call SaveInteger( udg_hash, GetHandleId(trig), KEY_NAME, index )
		set trig = null
	endfunction
	
	/*Event Creation*/
	private function CreateEvents takes nothing returns nothing
		local integer i = 1
		
		loop
			exitwhen i >= EventDatabase_EventUsed_Max
			call CreateEvent(i)
			set i = i + 1
		endloop
		
		set i = 1
		loop
			exitwhen i >= EventSystem_EventUsedCustom_Max
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