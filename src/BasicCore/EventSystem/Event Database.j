library EventDatabase initializer init requires EventSystem

	/*Custom Event Init*/
    globals
        Event PotionUsed //Event_PotionUsed
        /*
            caster 
        */
        
        Event BattleStart //"udg_FightStart_Real" 
         /*
            caster
            index
            owner
        */
    endglobals
    
    private function InitCustomEvents takes nothing returns nothing
        set PotionUsed = Event.create("caster", null)
        set BattleStart = Event.create("caster", null)
    endfunction
    
    /*Base Event Init*/
    globals
		public playerunitevent array EventUsed
		public integer EventUsed_Max = 1
	endglobals
	
	private function SetBaseEvent takes playerunitevent eventUsed returns nothing
		set EventUsed[EventUsed_Max] = eventUsed
		set EventUsed_Max = EventUsed_Max + 1
    endfunction
    
	private function InitBaseEvents takes nothing returns nothing
		call SetBaseEvent(EVENT_PLAYER_UNIT_SPELL_EFFECT)
    endfunction
    
    /*Init*/
    private function init takes nothing returns nothing
    	call InitBaseEvents()
    	call InitCustomEvents()
    endfunction

endlibrary