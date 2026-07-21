scope CalmPotion initializer init

	globals
		private constant integer ABILITY_ID = 'A1IP'
		
		private constant integer EFFECT_ID = 'A1IN'
		private constant integer BUFF_ID = 'B0B6'
		
		private constant integer SPELL_POWER_TO_ADD = 20
		
		private constant integer HASH_KEY = StringHash("calm_potion")
		
		private constant string ANIMATION = "Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl"
		
		public trigger Trigger = null
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID and combat(GetSpellAbilityUnit(), true, GetSpellAbilityId())
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster
		local integer id
		local integer spellPowerSummary
		
		if CastLogic() then
	        set caster = udg_Caster
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        call textst( "|cf0008080 Calm", caster, 64, 90, 10, 1.5 )
	    else
	        set caster = GetSpellAbilityUnit()
	    endif

		if combat(caster, false, 0) == false then
			set caster = null
			return
		endif
		
		set id = GetHandleId(caster)
		set spellPowerSummary = LoadInteger(udg_hash, id, HASH_KEY ) + SPELL_POWER_TO_ADD
		call SaveInteger(udg_hash, id, HASH_KEY, spellPowerSummary )
		
		call UnitAddAbility(caster, EFFECT_ID)
		call spdst( caster,  SPELL_POWER_TO_ADD )
		call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "origin") )
		
		set caster = null
	endfunction
	
	//===========================================================================
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT_ID) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        local unit hero = Event_DeleteBuff_Unit
        local integer id = GetHandleId(hero)
        local integer spellPowerSummary = LoadInteger(udg_hash, id, HASH_KEY )
	    
	    call spdst( hero, -spellPowerSummary )
	    call SaveInteger(udg_hash, id, HASH_KEY, 0 )
	    call UnitRemoveAbility( hero, EFFECT_ID )
        call UnitRemoveAbility( hero, BUFF_ID )

        set hero = null
    endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		set Trigger = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
		call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
	endfunction

endscope