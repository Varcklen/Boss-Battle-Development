scope CurseFirstBlood initializer init

	globals
		private trigger Trigger = null
		
		private constant integer EFFECT = 'A1D0'
        private constant integer BUFF = 'B0AA'
	endglobals

	private function AddEffect takes unit caster returns nothing
		call UnitAddAbility(caster, EFFECT)
	endfunction

    private function action takes nothing returns nothing
    	local unit caster = BattleStart.GetDataUnit("caster")
    	
        call AddEffect(caster)
        
        set caster = null
    endfunction
    
    private function FightEnd_Conditions takes nothing returns boolean
        return IsUnitHasAbility(udg_FightEnd_Unit, EFFECT)
    endfunction
    
    private function FightEnd takes nothing returns nothing
        call UnitRemoveAbility(udg_FightEnd_Unit, EFFECT)
    endfunction
    
    private function AfterHealChange_Conditions takes nothing returns boolean
        return IsUnitHasAbility(Event_AfterHealChange_Target, EFFECT) and Event_AfterHealChange_Heal > 0 and IsUnitHealthIsFull(Event_AfterHealChange_Target) == false
    endfunction
    
    private function AfterHealChange takes nothing returns nothing
        set Event_AfterHealChange_Heal = 0
        call UnitRemoveAbility(Event_AfterHealChange_Target, EFFECT)
        call UnitRemoveAbility(Event_AfterHealChange_Target, BUFF)
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
					call AddEffect(udg_hero[i])
				endif
				set i = i + 1
			endloop
		endif
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = BattleStart.AddListener(function action, null)
		call DisableTrigger( Trigger )
		
        call CreateEventTrigger( "udg_FightEnd_Real", function FightEnd, function FightEnd_Conditions )
        call CreateEventTrigger( "Event_AfterHealChange_Real", function AfterHealChange, function AfterHealChange_Conditions )
	endfunction

endscope