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
    
    	//private constant string KEY_NAME_STRING = 
		private constant integer KEY_NAME = StringHash("data_to_save")
		private constant integer EVENT_AMOUNT = StringHash("event_amount")
		private constant integer USED_UNIT_HASH = StringHash("used_unit")
		
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
	//==========================================================
	private function LaunchBase takes unit triggerUnit, integer index returns nothing
		local integer i
		local integer iMax
		local integer number
		local item itemCheck
		
		//call BJDebugMsg("triggerUnit: " + GetUnitName(triggerUnit))
		if IsUnitType( triggerUnit, UNIT_TYPE_HERO) == false then
			return
		endif
		//call BJDebugMsg("CONTINUE")
	
		set i = 0
		set iMax = UnitInventorySize(triggerUnit)
		loop
			exitwhen i >= iMax
			set itemCheck = UnitItemInSlot( triggerUnit, i )
			set number = LoadInteger( ItemTypeData, GetItemTypeId(itemCheck), KEY_NAME )
			if number != 0 and BaseEventSystem_EventUsed[index].Event == EventType[number] then
				set ItemUsed = itemCheck
				call ConditionalTriggerExecute( TriggerToExecute[number] )
			endif
			set i = i + 1
		endloop
		set itemCheck = null
	endfunction
	
	private function ExecuteAction takes unit triggerUnit returns nothing
		local integer index = LoadInteger( udg_hash, GetHandleId(GetTriggeringTrigger()), KEY_NAME )
		/*local BaseEvent baseEvent = BaseEventSystem_GetBaseEvent(index)
		local unit targetUnit = BaseEventSystem_GetTargetUnit(baseEvent.TargetId)*/

		/*TriggerUnit*/
		//call BJDebugMsg("TriggerUnit")
		call LaunchBase(triggerUnit, index)
		/*TargetUnit*/
		/*if triggerUnit != targetUnit then
			call BJDebugMsg("targetUnit")
			call LaunchBase(targetUnit, index)
		endif*/
		
		set ItemUsed = null
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
		call TriggerRegisterAnyUnitEventBJ( trig, BaseEventSystem_EventUsed[index].Event )
	    call TriggerAddAction( trig, function ActionUse )
	    call SaveInteger( udg_hash, GetHandleId(trig), KEY_NAME, index )
	    set trig = null
	endfunction
	//==========================================================
	
	
	/*Custom Events*/
	//==========================================================
	private function LaunchTrigger takes integer index, integer itemType, integer stringNumber, item itemCheck, string unitTypeName returns nothing
		local integer number = LoadInteger( ItemTypeData, itemType, KEY_NAME + stringNumber )
		local string unitUsed = LoadStr( ItemTypeData, itemType, USED_UNIT_HASH )
		
		/*call BJDebugMsg("number: " + I2S(number))
		call BJDebugMsg("index: " + I2S(index))*/
		if number == 0 then
			return
		endif
		
		if EventSystem_EventUsedCustom[index] != EventTypeCustom[number] then
			//call BJDebugMsg("EventSystem_EventUsedCustom[index] != EventTypeCustom[number]")
			return
		endif
		
		/*call BJDebugMsg("number: " + I2S(number))
		call BJDebugMsg("unitUsed: " + unitUsed)
		call BJDebugMsg("unitTypeName: " + unitTypeName)*/
		if ( unitUsed == null or unitUsed == unitTypeName ) == false then
			//call BJDebugMsg("( unitUsed == null or unitUsed == unitTypeName ) == false")
			return
		endif
		//call BJDebugMsg("works!")
		
		//call BJDebugMsg("trigger!")
		set ItemUsed = itemCheck
		call ConditionalTriggerExecute( TriggerToExecute[number] )
	endfunction
	
	private function NumberCheck takes integer index, item itemCheck, string unitTypeName returns nothing
		local integer itemType = GetItemTypeId(itemCheck)
		local integer amountOfEvents = LoadInteger(ItemTypeData, itemType, EVENT_AMOUNT)
		local integer i
		
		/*call BJDebugMsg("item: " + GetItemName(itemCheck))
		call BJDebugMsg("amountOfEvents: " + I2S(amountOfEvents))*/
 		if amountOfEvents == 1 then
			call LaunchTrigger(index, itemType, amountOfEvents, itemCheck, unitTypeName)
		else
			set i = 1
			loop
				exitwhen i > amountOfEvents
				call LaunchTrigger(index, itemType, i, itemCheck, unitTypeName)
				set i = i + 1
			endloop
		endif
	endfunction
	
	private function Launch takes unit triggerUnit, integer index, string unitTypeName returns boolean
		local integer i
		local integer iMax
		local integer number
		local item itemCheck
		
		if IsUnitType( triggerUnit, UNIT_TYPE_HERO) == false then
			return false
		endif
	
		set i = 0
		set iMax = UnitInventorySize(triggerUnit)
		loop
			exitwhen i >= iMax
			set itemCheck = UnitItemInSlot( triggerUnit, i )
			call NumberCheck(index, itemCheck, unitTypeName)
			set i = i + 1
		endloop
		set itemCheck = null
		return true
	endfunction
	
	/*private function FindHero takes unit triggeredUnit, unit targetUnit, integer index returns unit
		local boolean isTriggerUnitHero = IsUnitType( triggeredUnit, UNIT_TYPE_HERO)
		local boolean isTargetUnitHero = IsUnitType( targetUnit, UNIT_TYPE_HERO)
		
		if isTriggerUnitHero and isTargetUnitHero and triggeredUnit != targetUnit then
			call BJDebugMsg("isTriggerUnitHero and isTargetUnitHero")
			call Launch(triggeredUnit, index)
			return targetUnit
		elseif isTriggerUnitHero then
			call BJDebugMsg("isTriggerUnitHero")
			return triggeredUnit
		elseif isTargetUnitHero then
			call BJDebugMsg("isTargetUnitHero")
			return targetUnit
		endif
		return null
	endfunction*/
	
	private function ExecuteActionCustom takes nothing returns nothing
		local Event currentEvent = Event.Current
		local integer index = LoadInteger( udg_hash, GetHandleId(GetTriggeringTrigger()), KEY_NAME )
		
		/*if hero != null then
			call Launch(hero, index)
		endif*/
		/*call BJDebugMsg("=====================================")
		call BJDebugMsg("currentEvent.TriggerUnit: " + GetUnitName(currentEvent.TriggerUnit))
		call BJDebugMsg("currentEvent.TargetUnit: " + GetUnitName(currentEvent.TargetUnit))*/
		
		/*TriggerUnit*/
		call Launch(currentEvent.TriggerUnit, index, currentEvent.TriggerUnitName)
		/*TargetUnit*/
		if currentEvent.TargetUnit != currentEvent.TriggerUnit then
			call Launch(currentEvent.TargetUnit, index, currentEvent.TargetUnitName)
		endif
		
		set ItemUsed = null
	endfunction
	
	globals
        private trigger tempTrigTwo = null
    endglobals
	
	function RegisterDuplicatableItemTypeCustom takes integer itemType, Event eventType, code action, code condition, string usedUnitName returns trigger
	    local integer amountOfEvents = LoadInteger(ItemTypeData, itemType, EVENT_AMOUNT) + 1
	    local integer stringHash
	    
	    //local item TEST
	    
	    set tempTrigTwo = CreateTrigger()
	    
	    call TriggerAddAction( tempTrigTwo, action )
	    if condition != null then
	    	call TriggerAddCondition( tempTrigTwo, Condition( condition ) )
	    endif
	    
	    set TriggerToExecute[ActionListMax] = tempTrigTwo
	    set ItemType[ActionListMax] = itemType
	    set EventTypeCustom[ActionListMax] = eventType
	    
	    call SaveInteger( ItemTypeData, itemType, KEY_NAME, ActionListMax )
	    
	    set stringHash = KEY_NAME + amountOfEvents
	    call SaveInteger( ItemTypeData, itemType, stringHash, ActionListMax )
	    call SaveStr( ItemTypeData, itemType, USED_UNIT_HASH, usedUnitName )
	    
	    set ActionListMax = ActionListMax + 1
	    
	    /*set TEST = CreateItem(itemType, 0, 0)
	    call BJDebugMsg("itemType: " + GetItemName(TEST))
	    call BJDebugMsg("ActionListMax: " + I2S(ActionListMax - 1))*/
	    
	    call SaveInteger(ItemTypeData, itemType, EVENT_AMOUNT, amountOfEvents )
	    
		return tempTrigTwo
	endfunction
	
	private function CreateEventCustom takes integer index returns nothing
		local Event eventUsed = EventSystem_EventUsedCustom[index]
		local trigger trig = eventUsed.AddListener(function ExecuteActionCustom, null)
		call SaveInteger( udg_hash, GetHandleId(trig), KEY_NAME, index )
		set trig = null
	endfunction
	//==========================================================
	
	/*Event Creation*/
	private function CreateEvents takes nothing returns nothing
		local integer i = 1
		
		loop
			exitwhen i >= BaseEventSystem_EventUsed_Max
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