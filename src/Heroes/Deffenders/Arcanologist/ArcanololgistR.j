scope ArcanologistR initializer init

    globals
		private constant integer ABILITY_ID = 'A1HH'
		
		private constant integer EFFECT_ID = 'A1HJ'
		private constant integer BUFF_ID = 'B0AU'
		
		private constant integer EXTRA_INT_INITIAL = 10
		private constant integer EXTRA_INT_PER_LEVEL = 5
		
		private constant integer HASH_KEY = StringHash("arcanologist_r_int")
		
		private constant string ANIMATION = "AncientExplode1.mdx"
		
		trigger ArcanologistR = null
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID and combat(GetSpellAbilityUnit(), true, GetSpellAbilityId())
	endfunction
	
	private function Use takes unit caster, unit target, integer level returns nothing
		local integer extraINT
	
		if IsPermaBuffAffected(target) == false then
			call LaunchShortCooldown(caster, GetSpellAbilityId(), level)
			return
		endif
	
		if GetUnitAbilityLevel( target, EFFECT_ID) > 0 then
			if GetSpellAbilityId() == ABILITY_ID then
				call ErrorMessage( GetOwningPlayer(caster), "|cffffcc00" + GetAbilityName(ABILITY_ID) + "|r: The target is already affected by this spell." )
				call LaunchShortCooldown(caster, GetSpellAbilityId(), level)
			endif
			return
		endif
		
		if IsUnitDead(target) then
			if GetSpellAbilityId() == ABILITY_ID then
				call ErrorMessage( GetOwningPlayer(caster), "|cffffcc00" + GetAbilityName(ABILITY_ID) + "|r: The target is dead." )
				call LaunchShortCooldown(caster, GetSpellAbilityId(), level)
			endif
			return
		endif
	
		set extraINT = EXTRA_INT_INITIAL + EXTRA_INT_PER_LEVEL * level
		call UnitAddAbility(target, EFFECT_ID)
		
		call statst( target, 0, 0, extraINT, 0, false )
		
		call SaveInteger(udg_hash, GetHandleId(target), HASH_KEY, extraINT )
	
		call DestroyEffect( AddSpecialEffectTarget( ANIMATION, target, "origin") )
	endfunction
	
	private function action takes nothing returns nothing
	    local integer lvl
	    local unit caster
	    local unit target
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set target = udg_Target
	        set lvl = udg_Level
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set target = randomtarget( caster, 900, "ally", RT_HERO, 0, 0 )
	        set lvl = udg_Level
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	    else
	        set caster = GetSpellAbilityUnit()
	        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())
	        set target = GetSpellTargetUnit()
	    endif

		call Use(caster, target, lvl)
	    
	    set caster = null
	    set target = null
	endfunction
	
	//===========================================================================
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT_ID) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        local unit hero = Event_DeleteBuff_Unit
        local integer id = GetHandleId(hero)
        local integer extraINT = LoadInteger(udg_hash, id, HASH_KEY )
        
	    if IsUnitAlive(hero) then
	        call UnitRemoveAbility( hero, EFFECT_ID )
	        call UnitRemoveAbility( hero, BUFF_ID )

	        call statst( hero, 0, 0, -extraINT, 0, false )

	        call RemoveSavedInteger( udg_hash, id, HASH_KEY )
	    endif

        set hero = null
    endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set ArcanologistR = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( ArcanologistR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( ArcanologistR, Condition( function condition ) )
	    call TriggerAddAction( ArcanologistR, function action )
	    
	    call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
	endfunction

endscope

