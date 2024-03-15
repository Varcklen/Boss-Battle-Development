library EventDatabase initializer init requires EventSystem

	/*Custom Event Init*/
    globals
        Event PotionUsed //Event_PotionUsed
        /*
            caster (unit)
        */
        
        Event BattleStart //"udg_FightStart_Real" 
         /*
            caster (unit)
            index (integer)
            owner (player)
        */
        
        Event AllHeroesDied
        /*
        */
        
        Event BetweenBattles
        /*
        */
        
        Event SetRandomHeroes
        /*
        */
        
        Event ChangeCooldown
        /*
        	caster (unit)
        	new_value (real)
        	static_value (real)
        */
        Event ChangeBuffDuration
        /*
        	caster (unit)
        	new_value (real)
        	static_value (real)
        */
        Event ChangeMagaHealBonus
        /*
        	caster (unit)
        	new_value (real)
        	static_value (real)
        */
        Event ChangeGlobalJuleShopCost
        /*
        	caster (unit)
        	new_value (real)
        	static_value (real)
        */
    endglobals
    
    private function InitCustomEvents takes nothing returns nothing
        set PotionUsed = Event.create("caster", null)
        set BattleStart = Event.create("caster", null)
        set AllHeroesDied = Event.create(null, null)
        set BetweenBattles = Event.create(null, null)
        set SetRandomHeroes = Event.create(null, null)
        set ChangeCooldown = Event.create("caster", null)
        set ChangeBuffDuration = Event.create("caster", null)
        set ChangeMagaHealBonus = Event.create("caster", null)
        set ChangeGlobalJuleShopCost = Event.create("caster", null)
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