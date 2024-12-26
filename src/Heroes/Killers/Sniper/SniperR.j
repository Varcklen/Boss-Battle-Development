scope SniperR initializer init

    globals
		trigger trg_SniperR = null
		private constant integer ABILITY_ID = 'A0LN'
    endglobals
    
function Trig_SniperR_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == ABILITY_ID
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
    local real mana
    
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
        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, ABILITY_ID)
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    endif
	
	if Aspects_IsHeroAspectActive( caster, ASPECT_03 ) then
    	set heal = 67.5 + ( 67.5 * lvl )
    	set mana = 22.5 + ( 22.5 * lvl )
        set it = CreateItem( 'I0HC', x, y )
        call SaveReal( udg_hash, GetHandleId( it ), StringHash( "snprm" ), mana )
    else
    	set heal = 90. + ( 90. * lvl )
        set it = CreateItem( 'I05T', x, y )
    endif

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

