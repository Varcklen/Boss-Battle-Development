function Trig_Troll_MageW_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A14X' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
endfunction

function Troll_MageWEnd takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
	local unit u = LoadUnitHandle( udg_hash, id, StringHash( "trmw1" ) )
	
    call UnitRemoveAbility( u, 'A14Z' )
    call UnitRemoveAbility( u, 'B06W' )
    call FlushChildHashtable( udg_hash, id )
	
	set u = null
endfunction

function Troll_MageWCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "trmw" ) )
    local real lvl = LoadInteger( udg_hash, id, StringHash( "trmw" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "trmwx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "trmwy" ) )
	local integer id1
    local real t = 1+(lvl*2)
    set t = timebonus(u, t)
    
    call SetUnitPosition( u, x, y )
    call DestroyEffect( AddSpecialEffectTarget("Void Teleport Caster.mdx", u, "origin" ) )
	
	call UnitAddAbility( u, 'A14Z' )
	set id1 = GetHandleId( u )
    if LoadTimerHandle( udg_hash, id1, StringHash( "trmw1" ) ) == null  then
        call SaveTimerHandle( udg_hash, id1, StringHash( "trmw1" ), CreateTimer() )
    endif
	set id1 = GetHandleId( LoadTimerHandle( udg_hash, id1, StringHash( "trmw1" ) ) ) 
	call SaveUnitHandle( udg_hash, id1, StringHash( "trmw1" ), u )
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "trmw1" ) ), t, false, function Troll_MageWEnd )
	
    call FlushChildHashtable( udg_hash, id )
    
    set u = null
endfunction

function Trig_Troll_MageW_Actions takes nothing returns nothing
    local integer id
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
        call textst( udg_string[0] + GetObjectName('A14X'), caster, 64, 90, 10, 1.5 )
		set lvl = udg_Level
    else
        set caster = GetSpellAbilityUnit()
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
	set lvl = GetUnitAbilityLevel( caster, GetSpellAbilityId())
    endif
    
    if not( GetRectMinX(udg_Boss_Rect) <= x and x <= GetRectMaxX(udg_Boss_Rect) and GetRectMinY(udg_Boss_Rect) <= y and y <= GetRectMaxY(udg_Boss_Rect) ) then
        set caster = null
        return
    endif

    call manast( caster, null, 5+(5*lvl))

    set id = GetHandleId( caster )

    call SaveTimerHandle( udg_hash, id, StringHash( "trmw" ), CreateTimer() )
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "trmw" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "trmw" ), caster )
	call SaveReal( udg_hash, id, StringHash( "trmwx" ), x )
    call SaveReal( udg_hash, id, StringHash( "trmwy" ), y )
	call SaveInteger( udg_hash, id, StringHash( "trmw" ), lvl )
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "trmw" ) ), 0.01, false, function Troll_MageWCast )

    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'u000', x, y, 270 )
    call UnitAddAbility( bj_lastCreatedUnit, 'A04J' )

    set caster = null
endfunction

//===========================================================================
function InitTrig_Troll_MageW takes nothing returns nothing
    set gg_trg_Troll_MageW = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Troll_MageW, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Troll_MageW, Condition( function Trig_Troll_MageW_Conditions ) )
    call TriggerAddAction( gg_trg_Troll_MageW, function Trig_Troll_MageW_Actions )
endfunction