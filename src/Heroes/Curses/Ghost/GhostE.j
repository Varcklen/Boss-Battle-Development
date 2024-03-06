scope GhostE initializer init

	globals
		private constant integer ABILITY_ID = 'A08U'
		
		private constant real SPELL_POWER_BONUS_INITIAL = 0
		private constant real SPELL_POWER_BONUS_PER_LEVEL = 0.15
		
		private constant string ANIMATION = "Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl"
	
		unit Event_MaliceTrigger_Hero
		real Event_MaliceTrigger = 0
	endglobals
	
    private function condition takes nothing returns boolean
	    return GetUnitAbilityLevel( Event_MaliceTrigger_Hero, ABILITY_ID ) > 0 and combat( Event_MaliceTrigger_Hero, false, 0 ) and udg_fightmod[3] == false
	endfunction
        
    private function action takes nothing returns nothing
    	local unit caster = Event_MaliceTrigger_Hero
    	local integer index = GetPlayerId(GetOwningPlayer(caster)) + 1
    	local integer level = GetUnitAbilityLevel(caster, ABILITY_ID)
    	local real spellPowerToAdd = SPELL_POWER_BONUS_PER_LEVEL * level + SPELL_POWER_BONUS_INITIAL
    	
	    call spdst( caster,  spellPowerToAdd )
        set udg_Data[index + 112] = udg_Data[index + 112] + level
        call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "origin" ) )
        
        set caster = null
	endfunction

	private function init takes nothing returns nothing
	    call CreateEventTrigger( "Event_MaliceTrigger", function action, function condition )
	endfunction

endscope