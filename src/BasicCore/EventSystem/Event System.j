library EventSystem initializer init

    globals
        private hashtable hash = null
        
        private constant integer LISTENER_LIMIT = 90 //Issue: limit in 90 listenerss
        
        private trigger tempTrigger
        
        public Event array EventUsedCustom
		public integer EventUsedCustom_Max = 1
    endglobals

    struct Event
        private trigger array listeners[LISTENER_LIMIT] 
        private integer listenerAmount = 0
        readonly integer id
        
        readonly unit TriggerUnit
        readonly string TriggerUnitName
        
        readonly unit TargetUnit
        readonly string TargetUnitName
        
        readonly static thistype Current
        
        method AddListener takes code action, code condition returns trigger
            set tempTrigger = CreateTrigger()
            
            if listenerAmount + 1 >= LISTENER_LIMIT then
                call BJDebugMsg("Error! EventSystem - Event - AddListener: You have reached your listener limit!")
            endif
            
            set listeners[listenerAmount] = tempTrigger
            set listenerAmount = listenerAmount + 1
            
            if condition != null then
                call TriggerAddCondition( tempTrigger, Condition( condition ) )
            endif
            if action != null then
                call TriggerAddAction( tempTrigger,  action )
            endif
            return tempTrigger
        endmethod

        method Invoke takes nothing returns nothing
            local integer i = 0
            local unit triggerUnit = .TriggerUnit
            local unit targetUnit = .TargetUnit
            loop
                exitwhen i >= listenerAmount
                if IsTriggerEnabled(listeners[i]) then
	                set Current = this
	                set .TriggerUnit = triggerUnit
	                set .TargetUnit = targetUnit
	                call ConditionalTriggerExecute(listeners[i])
                endif
                set i = i + 1
            endloop
            set .TriggerUnit = null
            set .TargetUnit = null
            
            set triggerUnit = null
            set targetUnit = null
        endmethod

        static method create takes string triggerUnit, string targetUnit returns thistype
            local thistype p = thistype.allocate()
            set p.id = si__Event_I
            
            set p.TriggerUnitName = triggerUnit
            set p.TargetUnitName = targetUnit
            
            set EventUsedCustom[EventUsedCustom_Max] = p
			set EventUsedCustom_Max = EventUsedCustom_Max + 1
            
            return p
        endmethod
        
        //! textmacro BaseValue takes TYPENAME, TYPEWORD  
        method SetData$TYPENAME$ takes string keyName, $TYPEWORD$ value returns nothing
            call Save$TYPENAME$( hash, .id, StringHash( keyName ), value )
        endmethod
        
        method GetData$TYPENAME$ takes string keyName returns $TYPEWORD$
            return Load$TYPENAME$( hash, .id, StringHash( keyName ) )
        endmethod
        //! endtextmacro
        
        //! runtextmacro BaseValue("Integer", "integer")
        //! runtextmacro BaseValue("Real", "real")
        //! runtextmacro BaseValue("Boolean", "boolean")
        
        //! textmacro HandleValue takes TYPENAME, TYPEWORD  
        method SetData$TYPENAME$ takes string keyName, $TYPEWORD$ value returns nothing
            call Save$TYPENAME$Handle( hash, .id, StringHash( keyName ), value )
        endmethod
        
        method GetData$TYPENAME$ takes string keyName returns $TYPEWORD$
            return Load$TYPENAME$Handle( hash, .id, StringHash( keyName ) )
        endmethod
        //! endtextmacro
        
        //! runtextmacro HandleValue("Player", "player")
        //! runtextmacro HandleValue("Item", "item")
        
        method SetDataUnit takes string keyName, unit value returns nothing
        	if keyName == .TriggerUnitName then
        		set .TriggerUnit = value
        	endif
        	if keyName == .TargetUnitName then
        		set .TargetUnit = value
        	endif
            call SaveUnitHandle( hash, .id, StringHash( keyName ), value )
        endmethod
        
        method GetDataUnit takes string keyName returns unit
            return LoadUnitHandle( hash, .id, StringHash( keyName ) )
        endmethod
    endstruct
    
    private function init takes nothing returns nothing
        set hash = InitHashtable()
    endfunction
    
endlibrary