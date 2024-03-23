scope SludgeQ initializer init

globals
	private constant integer ABILITYQ = 'A0R5'
	
	public trigger Trigger = null
endglobals

private function conditions takes nothing returns boolean
    return GetSpellAbilityId() == ABILITYQ and combat(GetSpellAbilityUnit(), true, ABILITYQ)
endfunction

private function actions takes nothing returns nothing
    local integer lvl
    local unit caster
	local real r
	local real hp
	local real at
	local integer d
    
    if CastLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
    elseif RandomLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName(ABILITYQ), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, ABILITYQ )
    endif

	set r = 0.25+(0.05*lvl)
	set at = BlzGetUnitBaseDamage(caster, 0)*r
	set hp = (BlzGetUnitMaxHP(caster)*r)+1
	
	set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'u00X', GetUnitX( caster ) + GetRandomReal( -250, 250 ), GetUnitY( caster ) + GetRandomReal( -250, 250 ), GetRandomReal( 0, 360 ) )
    call DestroyEffect(AddSpecialEffectTarget( "Objects\\Spawnmodels\\Demon\\DemonLargeDeathExplode\\DemonLargeDeathExplode.mdl", bj_lastCreatedUnit, "origin"))
	call DestroyEffect(AddSpecialEffectTarget( "Objects\\Spawnmodels\\Demon\\DemonLargeDeathExplode\\DemonLargeDeathExplode.mdl", caster, "origin"))
	
    call BlzSetUnitMaxMana( bj_lastCreatedUnit, R2I(BlzGetUnitMaxMana(caster)) )
    call SetUnitState( bj_lastCreatedUnit, UNIT_STATE_MANA, GetUnitState( bj_lastCreatedUnit, UNIT_STATE_MAX_MANA) )

	call BlzSetUnitMaxHP( bj_lastCreatedUnit, R2I(hp) )
    call BlzSetUnitBaseDamage( bj_lastCreatedUnit, R2I(at), 0 )

	if GetUnitAbilityLevel( caster, 'A0R7') > 0 then
		call UnitAddAbility( bj_lastCreatedUnit, 'A0SO')
		call SaveInteger( udg_hash, GetHandleId(bj_lastCreatedUnit), StringHash( "sldgw" ), GetUnitAbilityLevel( caster, 'A0R7') )
	endif

	if GetUnitAbilityLevel( caster, 'A0RA') > 0 then
		call UnitAddAbility( bj_lastCreatedUnit, 'A0SS')
		call SaveInteger( udg_hash, GetHandleId(bj_lastCreatedUnit), StringHash( "sldge" ), GetUnitAbilityLevel( caster, 'A0RA') )
	endif

    if GetUnitAbilityLevel( caster, 'A0T8') > 0 then
        call UnitAddAbility( bj_lastCreatedUnit, 'A0T6')
        if GetUnitAbilityLevel( caster, 'A0T8') >= 2 then
            call UnitAddAbility( bj_lastCreatedUnit, 'A0S6')
        endif
        if GetUnitAbilityLevel( caster, 'A0T8') >= 3 then
            call UnitAddAbility( bj_lastCreatedUnit, 'A0RW')
        endif
        if GetUnitAbilityLevel( caster, 'A0T8') >= 4 then
            call UnitAddAbility( bj_lastCreatedUnit, 'A0SD')
        endif
    endif

	set d = udg_Data[GetPlayerId( GetOwningPlayer( caster ) ) + 1 + 216] / 2
	if d > 20 then
		set d = 20
	endif
	call SetUnitScale( bj_lastCreatedUnit, 1 + (d * 0.03), 1 + (d * 0.03), 1 + (d * 0.03) )

    call UnitAddAbility( bj_lastCreatedUnit, udg_Ability_Uniq[GetPlayerId(GetOwningPlayer(caster)) + 1] )

	call SaveUnitHandle( udg_hash, GetHandleId(bj_lastCreatedUnit), StringHash( "sldg" ), caster )
	call SetUnitState( bj_lastCreatedUnit, UNIT_STATE_LIFE, GetUnitState( bj_lastCreatedUnit, UNIT_STATE_MAX_LIFE) )
	call BlzSetUnitMaxHP( caster, R2I(BlzGetUnitMaxHP(caster)-hp+1) )
    call BlzSetUnitBaseDamage( caster, R2I(BlzGetUnitBaseDamage(caster, 0)-at), 0 )

    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set Trigger = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( Trigger, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( Trigger, Condition( function conditions ) )
    call TriggerAddAction( Trigger, function actions )
endfunction

endscope