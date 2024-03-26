scope DeepPurple initializer init

globals
	private constant integer DURATION = 10
	private constant integer BOOST = 200
	private constant integer ABILITY = 'AZ08'
	private constant integer EXTRA_A = 'AZ09'
	private constant integer EXTRA_B = 'BZ09'
endglobals

private function conditions takes nothing returns boolean
    return ( GetSpellAbilityId() == ABILITY ) and ( combat( GetSpellAbilityUnit(), true, ABILITY ) )
endfunction

/*private function deepPurpleCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    
    call FlushChildHashtable( udg_hash, id )
endfunction*/

private function deepPurpleData takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "az08" ) )

    call SpellUniqueUnit( u, -LoadReal( udg_hash, GetHandleId( u ), StringHash( "az08" ) ) )
    call UnitRemoveAbility( u, EXTRA_A )
    call UnitRemoveAbility( u, EXTRA_B )
    call RemoveSavedReal( udg_hash, GetHandleId( u ), StringHash( "az08" ) )
    call FlushChildHashtable( udg_hash, id )
    
    set u = null
endfunction

private function actions takes nothing returns nothing
    local integer id 
    local real r
    local real rsum
    //local group g = CreateGroup()
    //local unit u
    local unit caster
    local real t = DURATION
    
    if CastLogic() then
        set caster = udg_Caster
        set t = udg_Time
    elseif RandomLogic() then
        set caster = udg_Caster
        call textst( udg_string[0] + GetObjectName('IZ08'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
    endif
    set t = timebonus(caster, t)
    
    set r = BOOST * eyest( caster )
    set id = GetHandleId( caster )
    
    if IsUnitType( caster, UNIT_TYPE_HERO) then
        call SpellUniqueUnit( caster, r )
        set rsum = LoadReal( udg_hash, GetHandleId( caster ), StringHash( "az08" ) ) + r
        call UnitAddAbility( caster, EXTRA_A )
        //call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Weapons\\GryphonRiderMissile\\GryphonRiderMissileTarget.mdl", caster, "origin") )
        
        if LoadTimerHandle( udg_hash, GetHandleId( caster), StringHash( "az08" ) ) == null then
            call SaveTimerHandle( udg_hash, GetHandleId( caster), StringHash( "az08" ), CreateTimer() )
        endif
        set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "az08" ) ) ) 
        call SaveUnitHandle( udg_hash, id, StringHash( "az08" ), caster )
        call SaveReal( udg_hash, GetHandleId( caster ), StringHash( "az08" ), rsum )
        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "az08" ) ), t, false, function deepPurpleData ) 
    endif
    
    set caster = null
endfunction


//===========================================================================
private function init takes nothing returns nothing
    local trigger trig = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trig, Condition( function conditions ) )
    call TriggerAddAction( trig, function actions )
    set trig = null
endfunction

endscope