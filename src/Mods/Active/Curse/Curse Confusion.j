scope CurseConfusion initializer init

	globals
		private trigger Trigger = null
		
		private constant integer DURATION = 10
        private constant string ANIMATION = "Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl"
	endglobals

    private function ReturnMana takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer( ) )
        local unit hero = LoadUnitHandle(udg_hash, id, StringHash("curse_confusion") )
        local real manaStealed = LoadReal(udg_hash, id, StringHash("curse_confusion") )
        
        call PlaySpecialEffect(ANIMATION, hero)
        call SetUnitState( hero, UNIT_STATE_MANA, GetUnitState( hero, UNIT_STATE_MANA ) + manaStealed )
        call FlushChildHashtable( udg_hash, id )
        
        set hero = null
    endfunction
    
    private function Launch takes unit hero returns nothing
    	local real manaStealed = 0.5*GetUnitState( hero, UNIT_STATE_MANA)
        local integer id
        
        call PlaySpecialEffect(ANIMATION, hero)
        call SetUnitState( hero, UNIT_STATE_MANA, GetUnitState( hero, UNIT_STATE_MANA ) - manaStealed )
        set id = InvokeTimerWithUnit(hero, "curse_confusion", DURATION, false, function ReturnMana )
        call SaveReal(udg_hash, id, StringHash("curse_confusion"), manaStealed )
    endfunction

    private function FightStart takes nothing returns nothing
        call Launch(udg_FightStart_Unit)
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		local integer i
		call EnableTrigger( Trigger )
		if udg_fightmod[0] then
			set i = 1
			loop
				exitwhen i > 4
				if IsUnitAlive(udg_hero[i]) then
					call Launch(udg_hero[i])
				endif
				set i = i + 1
			endloop
		endif
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightStart_Real", function FightStart, null )
		call DisableTrigger( Trigger )
	endfunction

endscope