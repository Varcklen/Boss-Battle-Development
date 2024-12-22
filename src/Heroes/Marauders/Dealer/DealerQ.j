scope DealerQ initializer init 
    globals
		trigger trg_DealerQ = null
    endglobals

function Trig_DealerQ_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A183'
endfunction

function SpawnBanana takes unit caster, real x, real y returns nothing
    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'o01B', x, y, GetRandomReal( 0, 360 ) )
    call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", bj_lastCreatedUnit, "origin" ) )
    call UnitApplyTimedLife( bj_lastCreatedUnit , 'BTLF', BERRY_DEALER_R_BANANA_LIFE_TIME )
    call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Demon\\DemonLargeDeathExplode\\DemonLargeDeathExplode.mdl", GetUnitX(  bj_lastCreatedUnit ), GetUnitY(  bj_lastCreatedUnit ) ) )

    set caster = null
endfunction

function Trig_DealerQ_Actions takes nothing returns nothing
    local unit caster
    local unit target
    local integer lvl
    local real dmg
    local integer bananas
    local real money
    local integer i
    local integer iEnd
    
    if CastLogic() then
        set caster = udg_Caster
        set target = udg_Target
        set lvl = udg_Level
    elseif RandomLogic() then
        set caster = udg_Caster
        set target = randomtarget( caster, 900, "all", 0, 0, 0 )
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName('A183'), caster, 64, 90, 10, 1.5 )
        if target == null then
            set caster = null
            return
        endif
    else
        set caster = GetSpellAbilityUnit()
        set target = GetSpellTargetUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    endif
    set dmg = 100 + ( 50 * lvl )
    set money = 30 + ( 10 * lvl )
    
    if lvl == 1 or lvl == 2 then
        set bananas = 1
    elseif lvl == 3 or lvl == 4 then
        set bananas = 2
    elseif lvl == 5 then
        set bananas = 3
    endif
    
    call DestroyEffect( AddSpecialEffectTarget( "Objects\\Spawnmodels\\Demon\\DemonLargeDeathExplode\\DemonLargeDeathExplode.mdl", target, "origin" ) )

    call UnitDamageTarget(caster, target, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
    if GetUnitState( target, UNIT_STATE_LIFE) <= 0.405 then
        if combat( caster, false, 0 ) and not( udg_fightmod[3] ) then
            call moneyst( caster, R2I(money) )
        endif
    else
        set i = 1
        set iEnd = bananas
        loop
            exitwhen i > iEnd
            call SpawnBanana( caster, Math_GetRandomX(GetUnitX( target ), 200), Math_GetRandomY(GetUnitY( target ), 200) )
            set i = i + 1
        endloop
    endif

    set caster = null
    set target = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_DealerQ = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_DealerQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_DealerQ, Condition( function Trig_DealerQ_Conditions ) )
    call TriggerAddAction( trg_DealerQ, function Trig_DealerQ_Actions )
endfunction

endscope