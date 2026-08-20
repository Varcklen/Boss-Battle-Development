scope RagePotion initializer init

	globals
		private constant integer ABILITY_ID = 'A1IO'
		
		private constant integer EFFECT_ID = 'A1IM'
		private constant integer BUFF_ID = 'B0B5'
		
		private constant real ATTACK_POWER_TO_ADD = 0.35
		
		private constant integer HASH_KEY = StringHash("rage_potion")
		
		private constant string ANIMATION = "Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl"
		
		public trigger Trigger = null
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID and combat(GetSpellAbilityUnit(), true, GetSpellAbilityId())
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster
		local integer id
		local integer attackPowerSummary
		local integer attackPowerToAdd
		
		if CastLogic() then
	        set caster = udg_Caster
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        call textst( "|cffA8142A Rage", caster, 64, 90, 10, 1.5 )
	    else
	        set caster = GetSpellAbilityUnit()
	    endif

		if combat(caster, false, 0) == false then
			set caster = null
			return
		endif
		
		set attackPowerToAdd = R2I( BlzGetUnitBaseDamage(caster, 0) * ATTACK_POWER_TO_ADD )
		set id = GetHandleId(caster)
		set attackPowerSummary = LoadInteger(udg_hash, id, HASH_KEY ) + attackPowerToAdd
		call SaveInteger(udg_hash, id, HASH_KEY, attackPowerSummary )
		
		call UnitAddAbility(caster, EFFECT_ID)
		call BlzSetUnitBaseDamage( caster, BlzGetUnitBaseDamage(caster, 0) + attackPowerToAdd, 0 )
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
        local integer attackPowerSummary = LoadInteger(udg_hash, id, HASH_KEY )
	    
	    call BlzSetUnitBaseDamage( hero, BlzGetUnitBaseDamage(hero, 0) - attackPowerSummary, 0 )
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