scope Farewell initializer init

    globals
    	private constant integer ABILITY_ID = 'A1HD'
		
		private constant integer DIST_MIN = 27
		private constant integer DIST_MAX = 38
		private constant real ANGLE_DRIFT = 12.5
		
		private constant integer HEIGHT = 900
		
		trigger trg_Farewell = null
    endglobals

private function Trig_Farewell_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == ABILITY_ID and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
endfunction

private function FarewellRun takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "frwl" ) )
    local integer counter = LoadInteger( udg_hash, id, StringHash( "frwl" ) ) + 1
    local real angle = LoadReal( udg_hash, id, StringHash( "frwl" ) )
    local real normalHeight = LoadReal( udg_hash, id, StringHash( "frwlh" ) )
    local integer knockback = LoadInteger( udg_hash, id, StringHash( "frwld" ) ) 
    local real NewX = GetUnitX( u ) + knockback * Cos( angle )
    local real NewY = GetUnitY( u ) + knockback * Sin( angle )

    if counter == 11 then
        call SetUnitFlyHeight( u, -HEIGHT, 2000 )
    endif

    if counter == 21 or GetUnitState( u, UNIT_STATE_LIFE) <= 0.405 then
		call SetUnitFlyHeight( u, normalHeight, 0 )
		call SetUnitPathing( u, true )
		call UnitRemoveAbility( u, 'Amrf' )
        call pausest( u, -1 )
        call DestroyTimer( GetExpiredTimer() )
    else 
        call SaveInteger( udg_hash, id, StringHash( "frwl" ), counter )
        if RectContainsCoords(udg_Boss_Rect, NewX, NewY) then
            call SetUnitPosition( u, NewX, NewY )
        endif
    endif
    
    set u = null
endfunction

private function Trig_Farewell_Actions takes nothing returns nothing
    local real x 
    local real y
    local integer id 
    local integer lvl
    local unit caster
    local real angle
    local integer dist
    local real normalHeight
    
    if CastLogic() then
        set caster = udg_Target
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    	set angle = Atan2( y - GetUnitY( caster ), x - GetUnitX( caster ) ) + GetRandomReal(-ANGLE_DRIFT, ANGLE_DRIFT) * bj_DEGTORAD
    elseif RandomLogic() then
        set caster = udg_Caster
        set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    	set angle = Atan2( y - GetUnitY( caster ), x - GetUnitX( caster ) ) + GetRandomReal(-ANGLE_DRIFT, ANGLE_DRIFT) * bj_DEGTORAD
    endif

    if GetUnitDefaultMoveSpeed(caster) != 0 and LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "frwl" ) ) == null then
    	call pausest( caster, 1 )
    	call UnitAddAbility( caster, 'Amrf' )
    	set normalHeight = GetUnitFlyHeight(caster)
    	call SetUnitFlyHeight( caster,  HEIGHT, 2000 )
    	call SetUnitPathing( caster, false )
    	set dist = GetRandomInt(DIST_MIN, DIST_MAX)
            
    	set id = InvokeTimerWithUnit( caster, "frwl", 0.03, true, function FarewellRun )
    	call SaveUnitHandle( udg_hash, id, StringHash( "frwl" ), caster)
    	call SaveReal( udg_hash, id, StringHash( "frwl" ), angle)
    	call SaveInteger( udg_hash, id, StringHash( "frwld" ), dist)
    	call SaveReal( udg_hash, id, StringHash( "frwlh" ), normalHeight)
    endif
            
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_Farewell = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_Farewell, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_Farewell, Condition( function Trig_Farewell_Conditions ) )
    call TriggerAddAction( trg_Farewell, function Trig_Farewell_Actions )
endfunction

endscope

