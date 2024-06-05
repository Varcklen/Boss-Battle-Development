scope BlessChosenOne initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function action takes nothing returns nothing
		local unit target = DeathSystem_GetRandomAliveHero()

        call UnitAddAbility( target, 'A0HU' )
        call spdst( target, 20 )
        call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl", target, "origin") )
        
        set target = null
	endfunction
	
	private function OnBetween_Condition takes nothing returns boolean
		return GetUnitAbilityLevel(Event_BetweenUnit_Hero, 'B03D') > 0
	endfunction
	
	private function OnBetween takes nothing returns nothing
		local unit target = Event_BetweenUnit_Hero
		
		call UnitRemoveAbility( target, 'A0HU' )
        call UnitRemoveAbility( target, 'B03D' )   
        call spdst( target, -20 )
		
		set target = null
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		if udg_fightmod[0] then
			call action()
		endif
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = BattleStartGlobal.AddListener(function action, null)
		call DisableTrigger( Trigger )
		
		call CreateEventTrigger( "Event_BetweenUnit", function OnBetween, function OnBetween_Condition )
	endfunction

endscope