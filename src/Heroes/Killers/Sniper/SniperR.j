scope SniperR initializer init

    globals
		trigger trg_SniperR = null
    endglobals
    
function Trig_SniperR_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0LN'
endfunction

function Trig_SniperR_Actions takes nothing returns nothing
    local unit caster
    local item it
    local integer lvl
    local real x
    local real y
    local real dist 
    local real angle 
    local real heal
    
    if CastLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        set x = GetLocationX( GetSpellTargetLoc() )
        set y = GetLocationY( GetSpellTargetLoc() )
    elseif RandomLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        set dist = GetRandomReal( 0, 730 )
        set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        set x = GetUnitX( caster ) + dist * Cos( angle )
        set y = GetUnitY( caster ) + dist * Sin( angle )
        call textst( udg_string[0] + GetObjectName('A0LN'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set x = GetLocationX( GetSpellTargetLoc() )
        set y = GetLocationY( GetSpellTargetLoc() )
    endif

    set heal = 90. + ( 90. * lvl )

        set it = CreateItem( 'I05T', x, y )
        call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageDeathCaster.mdl", x, y ) )
        call SaveUnitHandle( udg_hash, GetHandleId( it ), StringHash( "snpr" ), caster )
        call SaveReal( udg_hash, GetHandleId( it ), StringHash( "snpr" ), heal )
    
    set caster = null
    set it = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_SniperR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_SniperR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_SniperR, Condition( function Trig_SniperR_Conditions ) )
    call TriggerAddAction( trg_SniperR, function Trig_SniperR_Actions )
endfunction

endscope

