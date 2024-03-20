library BaseEventSystem

	/*Base Event*/
	globals
		public BaseEvent array EventUsed
		public integer EventUsed_Max = 1
	endglobals
	
    struct BaseEvent
    	readonly playerunitevent Event
    
    	static method create takes playerunitevent eventUsed returns thistype
            local thistype p = thistype.allocate()

            set p.Event = eventUsed
            
            set EventUsed[EventUsed_Max] = p
			set EventUsed_Max = EventUsed_Max + 1
            
            return p
        endmethod
    endstruct

endlibrary