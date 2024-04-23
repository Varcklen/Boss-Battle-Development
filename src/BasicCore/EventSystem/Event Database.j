library EventDatabase initializer init requires EventSystem, BaseEventSystem

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
        
        Event BattleEnd 
         /*
            caster (unit)
            index (integer)
            owner (player)
            is_win (boolean)
        */
        
        Event BattleStartGlobal
         /*
        */
        
        Event BattleEndGlobal
         /*
            is_win (boolean)
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
        Event BeforeAttack
        /*
        	caster (unit)
        	target (unit)
        	damage (real) -- can be changed in the trigger
        	static_damage (real)
        */
        Event AfterAttack
        /*
        	caster (unit)
        	target (unit)
        	damage (real)
        */
        Event BeforeItemSplit
        /*
        	caster (unit)
        	item_used (item)
        */
        Event UnitDied
        /*
        	killer (unit)
        	unit_died (unit)
        */
        Event AnyHeroDied
        /*
        	caster (unit)
        	unit_died (unit)
        */
        Event BeforeHeal
        /*
        	caster (unit)
        	target (unit)
        	heal (real) -- can be changed in the trigger
        	static_heal (real)
        */
        Event AfterHeal
        /*
        	caster (unit)
        	target (unit)
        	heal (real)
        	raw_heal (real)
        */
        Event AlliedMinionSummoned
        /*
        	caster (unit)
        	minion (unit)
        */
        Event AnyUnitDied
        /*
        	caster (unit)
        	unit_died (unit)
        */
        Event AfterJuleRefresh
        /*
        */
        Event ItemUsed
        /*
        	caster (unit)
        	amount_of_uses (integer) -- can be changed in the trigger
        */
        Event RuneSetGain
        /*
        	caster (unit)
        	item (item)
        */
        Event RuneSetLose
        /*
        	caster (unit)
        	item (item)
        */
        Event RuneSetGainCheck
        /*
        	caster (unit)
        	item (item)
        */
        Event RuneSetLoseCheck
        /*
        	caster (unit)
        	item (item)
        */
        Event CooldownReset
        /*
        	caster (unit)
        */
        Event BetweenGlobal
        /*
        	caster (unit)
        */
    endglobals
    
    private function InitCustomEvents takes nothing returns nothing
        set PotionUsed = Event.create("caster", null)
        set BattleStart = Event.create("caster", null)
        set BattleEnd = Event.create("caster", null)
        set AllHeroesDied = Event.create(null, null)
        set BetweenBattles = Event.create(null, null)
        set SetRandomHeroes = Event.create(null, null)
        set ChangeCooldown = Event.create("caster", null)
        set ChangeBuffDuration = Event.create("caster", null)
        set ChangeMagaHealBonus = Event.create("caster", null)
        set ChangeGlobalJuleShopCost = Event.create("caster", null)
        set BeforeAttack = Event.create("caster", "target")
        set AfterAttack = Event.create("caster", "target")
        set BeforeItemSplit = Event.create("caster", null)
        set UnitDied = Event.create("killer", "unit_died")
        set AnyHeroDied = Event.create("caster", "unit_died")
        set BeforeHeal = Event.create("caster", "target")
        set AfterHeal = Event.create("caster", "target")
        set AlliedMinionSummoned = Event.create("caster", "minion")
        set AnyUnitDied = Event.create("caster", "unit_died")
        set AfterJuleRefresh = Event.create(null, null)
        set ItemUsed = Event.create("caster", null)
        set RuneSetGain = Event.create("caster", null)
        set RuneSetLose = Event.create("caster", null)
        set RuneSetGainCheck = Event.create("caster", null)
        set RuneSetLoseCheck = Event.create("caster", null)
        set BattleStartGlobal = Event.create(null, null)
        set BattleEndGlobal = Event.create(null, null)
        set CooldownReset = Event.create("caster", null)
        set BetweenGlobal = Event.create(null, null)
    endfunction
    
    /*Base Event Init*/
	private function InitBaseEvents takes nothing returns nothing
		call BaseEvent.create(EVENT_PLAYER_UNIT_SPELL_EFFECT)
    endfunction
    
    /*Init*/
    private function init takes nothing returns nothing
    	call InitBaseEvents()
    	call InitCustomEvents()
    endfunction

endlibrary