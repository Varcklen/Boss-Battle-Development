function Trig_DealerW_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A187'
endfunction

function DealerWCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "dlrw" ) )
    
    call UnitRemoveAbility( u, 'A186' )
    call FlushChildHashtable( udg_hash, id )
    
     set u = null
endfunction

function Trig_DealerW_Actions takes nothing returns nothing
    local unit caster
    local integer lvl
    local real x
    local real y
    local real dist
    local real angle
    local group g = CreateGroup()
    local unit u
    local integer id
    local real t
    local integer chance
    
    if CastLogic() then
        set caster = udg_Target
        set lvl = udg_Level
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
        set t = udg_Time
    elseif RandomLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        set dist = GetRandomReal( 0, 730 )
        set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        set x = GetUnitX( caster ) + dist * Cos( angle )
        set y = GetUnitY( caster ) + dist * Sin( angle )
        call textst( udg_string[0] + GetObjectName('A187'), caster, 64, 90, 10, 1.5 )
        set t = 2 + lvl
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel( caster, GetSpellAbilityId())
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
        set t = 2 + lvl
    endif
    set t = timebonus(caster, t)
    
    call GroupEnumUnitsInRange( g, x, y, 300, null )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, caster, "all" ) then
            call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageDeathCaster.mdl", GetUnitX( u ), GetUnitY( u ) ) )
            /*call dummyspawn( caster, 1, 'A185', 0, 0 )
            call SetUnitAbilityLevel( bj_lastCreatedUnit, 'A185', lvl )
            call IssueTargetOrder( bj_lastCreatedUnit, "invisibility", u )
            call shadowst( u )*/
            call InvisibilitySystem_Apply(caster, u, t)

            call UnitAddAbility( u, 'A186' )
            
            set id = GetHandleId( u )
            if LoadTimerHandle( udg_hash, id, StringHash( "dlrw" ) ) == null then
                call SaveTimerHandle( udg_hash, id, StringHash( "dlrw" ), CreateTimer() )
            endif
            set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "dlrw" ) ) ) 
            call SaveUnitHandle( udg_hash, id, StringHash( "dlrw" ), u )
            call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "dlrw" ) ), t, false, function DealerWCast )
            
            set chance = 10
            if (u == caster) then
                set chance = chance * 2
            endif
            
            if luckylogic( caster, chance, 1, 100 ) then
                set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'o01B', GetUnitX(u) + GetRandomReal( -300, 300 ), GetUnitX(u) + GetRandomReal( -300, 300 ), GetRandomReal( 0, 360 ) )
                call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", bj_lastCreatedUnit, "origin" ) )
                call UnitApplyTimedLife( bj_lastCreatedUnit , 'BTLF', BERRY_DEALER_R_BANANA_LIFE_TIME )
                call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Demon\\DemonLargeDeathExplode\\DemonLargeDeathExplode.mdl", GetUnitX(  bj_lastCreatedUnit ), GetUnitY(  bj_lastCreatedUnit ) ) )
            endif
        endif
        call GroupRemoveUnit(g,u)
    endloop

    call GroupClear( g )
    call DestroyGroup( g )
    set u = null
    set g = null
    set caster = null
endfunction

//===========================================================================
function InitTrig_DealerW takes nothing returns nothing
    set gg_trg_DealerW = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_DealerW, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_DealerW, Condition( function Trig_DealerW_Conditions ) )
    call TriggerAddAction( gg_trg_DealerW, function Trig_DealerW_Actions )
endfunction

