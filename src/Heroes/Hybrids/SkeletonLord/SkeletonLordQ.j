scope SkeletonLordQ initializer init 

globals
	trigger trg_SkeletonLordQ = null
endglobals

function Trig_SkeletonLordQ_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0CL' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
endfunction

function Trig_SkeletonLordQ_Cast_Alt1 takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "sklq" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "sklqx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "sklqy" ) )
    local integer lvl = LoadInteger(  udg_hash, id, StringHash( "sklql" ) )
    local real dist
    local real angle
    local real x1
    local real y1
    local integer i
    local integer ie
    
    call SetUnitPosition( u, x, y )
    set i = 1
    set ie = lvl
    loop
        exitwhen i > ie
        set dist = GetRandomReal( 50, 300 )
        set angle = GetRandomReal( 0, 360 )
        set x1 = x + dist * Cos( angle * bj_DEGTORAD )
        set y1 = y + dist * Sin( angle * bj_DEGTORAD )
        call skeletXY( u, x1, y1, angle)
        set i = i + 1
    endloop
    
    call DestroyEffect( AddSpecialEffectTarget("Void Teleport Caster.mdx", u, "origin" ) )
    call FlushChildHashtable( udg_hash, id )
    
    set u = null
endfunction

function Trig_SkeletonLordQ_Cast_Alt2 takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "sklq" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "sklqx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "sklqy" ) )
    
    local integer lvl = LoadInteger(  udg_hash, id, StringHash( "sklql" ) )
    local real heal = LoadReal( udg_hash, id, StringHash( "sklq" ) )
    
    local real dist
    local real angle
    local real x1
    local real y1
    local integer i
    local integer ie
    
    call healst( u, null, heal )
    
    set i = 1
    set ie = lvl
    loop
        exitwhen i > ie
        set dist = GetRandomReal( 50, 200 )
        set angle = GetRandomReal( 0, 360 )
        set x1 = x + dist * Cos( angle * bj_DEGTORAD )
        set y1 = y + dist * Sin( angle * bj_DEGTORAD )
        call skeletXY( u, x1, y1, angle)
        set i = i + 1
    endloop
    
    //call DestroyEffect( AddSpecialEffectTarget("Void Teleport Caster.mdx", u, "origin" ) )
    call FlushChildHashtable( udg_hash, id )
    
    set u = null
endfunction

function Trig_SkeletonLordQ_Cast_Main takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "sklq" ) )
    local real heal = LoadReal( udg_hash, id, StringHash( "sklq" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "sklqx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "sklqy" ) )
    
    call SetUnitPosition( u, x, y )
    call healst( u, null, heal )
    call DestroyEffect( AddSpecialEffectTarget("Void Teleport Caster.mdx", u, "origin" ) )
    call FlushChildHashtable( udg_hash, id )
    
    set u = null
endfunction

function Trig_SkeletonLordQ_Actions takes nothing returns nothing
    local integer id
    local integer rnd
    local real heal
    local unit caster
    local integer lvl
    local real x
    local real y
    local real dist
    local real angle

    if CastLogic() then
        set caster = udg_Target
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
	set lvl = udg_Level
    elseif RandomLogic() then
        set caster = udg_Caster
        set dist = GetRandomReal( 0, 730 )
        set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        set x = GetUnitX( caster ) + dist * Cos( angle )
        set y = GetUnitY( caster ) + dist * Sin( angle )
        call textst( udg_string[0] + GetObjectName('A0CL'), caster, 64, 90, 10, 1.5 )
	set lvl = udg_Level
    else
        set caster = GetSpellAbilityUnit()
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
	set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    endif
    
    if not( GetRectMinX(udg_Boss_Rect) <= x and x <= GetRectMaxX(udg_Boss_Rect) and GetRectMinY(udg_Boss_Rect) <= y and y <= GetRectMaxY(udg_Boss_Rect) ) then
        set caster = null
        return
    endif

    set id = GetHandleId( caster )
    set heal = (0.04+(0.02*lvl))*GetUnitState( caster, UNIT_STATE_MAX_LIFE)

    call SaveTimerHandle( udg_hash, id, StringHash( "sklq" ), CreateTimer() )
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "sklq" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "sklq" ), caster )
	call SaveReal( udg_hash, id, StringHash( "sklqx" ), x )
    call SaveReal( udg_hash, id, StringHash( "sklqy" ), y )
    
    set rnd = GetRandomInt(0,2)
    //or (Aspects_IsHeroAspectActive( caster, ASPECT_03 ) and (rnd==1))
    
    if Aspects_IsHeroAspectActive( caster, ASPECT_01 ) or (Aspects_IsHeroAspectActive( caster, ASPECT_03 ) and (rnd==1)) then
		call SaveInteger( udg_hash, id, StringHash( "sklql" ), lvl )
		call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "sklq" ) ), 0.01, false, function Trig_SkeletonLordQ_Cast_Alt1 )
    elseif Aspects_IsHeroAspectActive( caster, ASPECT_02 ) or (Aspects_IsHeroAspectActive( caster, ASPECT_03 ) and (rnd==2)) then
		call SaveInteger( udg_hash, id, StringHash( "sklql" ), lvl )
		call SaveReal( udg_hash, id, StringHash( "sklq" ), heal )
		call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "sklq" ) ), 0.01, false, function Trig_SkeletonLordQ_Cast_Alt2 )
	else
		call SaveReal( udg_hash, id, StringHash( "sklq" ), heal )
		call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "sklq" ) ), 0.01, false, function Trig_SkeletonLordQ_Cast_Main )
	endif
       

    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_SkeletonLordQ = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_SkeletonLordQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_SkeletonLordQ, Condition( function Trig_SkeletonLordQ_Conditions ) )
    call TriggerAddAction( trg_SkeletonLordQ, function Trig_SkeletonLordQ_Actions )
endfunction

endscope