scope DevourerR initializer init

    globals
		trigger trg_DevourerR = null
    endglobals
    
function Trig_DevourerR_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A10J'
endfunction

function Trig_DevourerR_Actions takes nothing returns nothing
    local unit caster
    local integer cyclA
    local integer lvl
    local real x
    local real y
    local real dist 
    local real angle 
    local group g = CreateGroup()
    local unit u
    local integer i = 0
    local real dmg
    
    if CastLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    elseif RandomLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        set dist = GetRandomReal( 0, 730 )
        set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        set x = GetUnitX( caster ) + dist * Cos( angle )
        set y = GetUnitY( caster ) + dist * Sin( angle )
        call textst( udg_string[0] + GetObjectName('A10J'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    endif
    
    call GroupEnumUnitsInRange( g, x, y, 400, null )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, caster, "enemy" ) then
            set i = i + 1
        endif
        call GroupRemoveUnit(g,u)
    endloop
    
    if i > 0 then
        set dmg = ( 325 + ( lvl * 125 ) ) / i
        
        call GroupEnumUnitsInRange( g, x, y, 400, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, "enemy" ) then
                call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl", GetUnitX( u ), GetUnitY( u ) ) )
                call UnitDamageTarget( caster, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            endif
            call GroupRemoveUnit(g,u)
        endloop
    endif

    call DestroyGroup( g )
    set u = null
    set g = null
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_DevourerR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_DevourerR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_DevourerR, Condition( function Trig_DevourerR_Conditions ) )
    call TriggerAddAction( trg_DevourerR, function Trig_DevourerR_Actions )
endfunction

endscope

