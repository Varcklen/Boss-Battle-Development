scope GhostHeroW initializer init

    globals
		trigger trg_GhostW = null
    endglobals
    
function Trig_GhostW_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A05R'
endfunction

function GhostWCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "qhsw" ) )
    
    call UnitRemoveAbility( u, 'A0WP' )
    call UnitRemoveAbility( u, 'B01M' )
    call FlushChildHashtable( udg_hash, id )
    
     set u = null
endfunction

function Trig_GhostW_Actions takes nothing returns nothing
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
        call textst( udg_string[0] + GetObjectName('A05R'), caster, 64, 90, 10, 1.5 )
        set t = 25
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
        set t = 25
    endif
    set t = timebonus(caster, t)
    
    call GroupEnumUnitsInRange( g, x, y, 425, null )
    call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeTarget.mdl", x, y ) )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, caster, "enemy" ) then
            set id = GetHandleId( u )
    
            call UnitAddAbility( u, 'A0WP' )
            call SetUnitAbilityLevel( u, 'A0TA', lvl )
            call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageDeathCaster.mdl", GetUnitX( u ), GetUnitY( u ) ) )
        
            if LoadTimerHandle( udg_hash, id, StringHash( "qhsw" ) ) == null then
                call SaveTimerHandle( udg_hash, id, StringHash( "qhsw" ), CreateTimer() )
            endif
            set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "qhsw" ) ) ) 
            call SaveUnitHandle( udg_hash, id, StringHash( "qhsw" ), u )
            call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "qhsw" ) ), t, false, function GhostWCast )
            
            set Event_MaliceTrigger_Hero = caster
			set Event_MaliceTrigger = 1
			set Event_MaliceTrigger = 0
        endif
        call GroupRemoveUnit(g,u)
    endloop
    
    call DestroyGroup( g )
    set u = null
    set g = null
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_GhostW = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ(trg_GhostW, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_GhostW, Condition( function Trig_GhostW_Conditions ) )
    call TriggerAddAction( trg_GhostW, function Trig_GhostW_Actions )
endfunction


endscope
