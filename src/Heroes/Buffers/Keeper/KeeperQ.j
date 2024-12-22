function Trig_KeeperQ_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A09U' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
endfunction

function KeeperQCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "kepq" ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "kepq" ) )
    local real dmgbns = LoadReal( udg_hash, id, StringHash( "kepqb" ) )
    local real dmgdone = 0
    local real x = LoadReal( udg_hash, id, StringHash( "kepqx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "kepqy" ) )
    local real t = LoadReal( udg_hash, id, StringHash( "kepqt" ) )
    local group g = CreateGroup()
    local unit u
    
    call SetUnitPosition( caster, x, y )
    call DestroyEffect( AddSpecialEffectTarget("Blink Blue Target.mdx", caster, "origin" ) )
    call GroupEnumUnitsInRange( g, GetUnitX( caster ), GetUnitY( caster ), 350, null )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, caster, "enemy" ) then
            if GetUnitAbilityLevel( u, 'B09A') > 0 then
                set dmgdone = dmg+dmgbns
            else
                set dmgdone = dmg
            endif
            call UnitDamageTarget( caster, u, dmgdone, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
            call bufst( caster, u, 'A09W', 'B09A', "kepq1", t )
        endif
        call GroupRemoveUnit(g,u)
    endloop
    call FlushChildHashtable( udg_hash, id )
    
    call GroupClear( g )
    call DestroyGroup( g )
    set u = null
    set g = null
    set caster = null
endfunction

function Trig_KeeperQ_Actions takes nothing returns nothing
    local integer id
    local real dmg
    local real dmgbns
    local unit caster
    local integer lvl
    local real x
    local real y
    local real dist 
    local real angle 
    local real t

    if CastLogic() then
        set caster = udg_Target
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
        set lvl = udg_Level
        set t = udg_Time
    elseif RandomLogic() then
        set caster = udg_Caster
        set dist = GetRandomReal( 0, 730 )
        set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        set x = GetUnitX( caster ) + dist * Cos( angle )
        set y = GetUnitY( caster ) + dist * Sin( angle )
        call textst( udg_string[0] + GetObjectName('A09U'), caster, 64, 90, 10, 1.5 )
        set lvl = udg_Level
        set t = 5
    else
        set caster = GetSpellAbilityUnit()
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set t = 5
    endif
    
    if not( GetRectMinX(udg_Boss_Rect) <= x and x <= GetRectMaxX(udg_Boss_Rect) and GetRectMinY(udg_Boss_Rect) <= y and y <= GetRectMaxY(udg_Boss_Rect) ) then
        set caster = null
        return
    endif

    set t = timebonus( caster, t )
    set id = GetHandleId( caster )
    set dmg = 22+(8*lvl)* GetUnitSpellPower(caster)
    set dmgbns = 60+(20*lvl)* GetUnitSpellPower(caster)

    call SaveTimerHandle( udg_hash, id, StringHash( "kepq" ), CreateTimer() )
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "kepq" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "kepq" ), caster )
	call SaveReal( udg_hash, id, StringHash( "kepq" ), dmg )
    call SaveReal( udg_hash, id, StringHash( "kepqb" ), dmgbns )
	call SaveReal( udg_hash, id, StringHash( "kepqx" ), x )
    call SaveReal( udg_hash, id, StringHash( "kepqy" ), y )
    call SaveReal( udg_hash, id, StringHash( "kepqt" ), t )
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "kepq" ) ), 0.01, false, function KeeperQCast )

    set caster = null
endfunction

//===========================================================================
function InitTrig_KeeperQ takes nothing returns nothing
    set gg_trg_KeeperQ = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_KeeperQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_KeeperQ, Condition( function Trig_KeeperQ_Conditions ) )
    call TriggerAddAction( gg_trg_KeeperQ, function Trig_KeeperQ_Actions )
endfunction

