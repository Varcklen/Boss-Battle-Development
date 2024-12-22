scope MaidenQ initializer init

    globals
		trigger trg_MaidenQ = null
    endglobals

function Trig_MaidenQ_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A16G' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
endfunction

function MaidenQMove_Condition takes unit caster, unit target, integer id returns boolean
    local boolean isWork = true
    local unit correctTarget = LoadUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "mdnqtt" ) )
    local integer pattent = LoadInteger(udg_hash, id, StringHash( "mdnqp" ) )
    
    if IsUnitInvisible( target, Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
        set isWork = false
    elseif pattent != udg_Pattern then
        set isWork = false
    elseif IsUnitEnemy( target, GetOwningPlayer( caster ) ) then
        set isWork = false
    elseif caster == target then
        set isWork = false
    elseif correctTarget != target then
        set isWork = false
    elseif IsUnitDead(caster) then
        set isWork = false
    elseif IsUnitDead(target) then
        set isWork = false
    elseif GetUnitAbilityLevel(caster, 'Avul') > 0 then//Invul
        set isWork = false
    elseif GetUnitAbilityLevel(caster, 'A17U') > 0 then//Pudge Q
        set isWork = false
    elseif GetUnitAbilityLevel(caster, 'A16J') == 0 then//Invul from Q
        set isWork = false
    elseif GetUnitAbilityLevel(target, 'A16I') == 0 then//Buff from Q
        set isWork = false
    endif
    
    set caster = null
    set target = null
    set correctTarget = null
    return isWork
endfunction

function MaidenQMove takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "mdnq" ) )
    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "mdnqt" ) )
    local lightning l = LoadLightningHandle( udg_hash, GetHandleId( target ), StringHash( "mdnql" ) )

    if MaidenQMove_Condition(caster, target, id) then
        call SetUnitX(caster,GetUnitX( target ) + 150)
        call SetUnitY(caster,GetUnitY( target ) + 150)
    	call MoveLightningUnits( l, caster, target )
    else
        if IsUnitAlive(target) then
            call UnitRemoveAbility( target, 'A16I' )
            call UnitRemoveAbility( target, 'B07A' )
        endif
        call SetUnitPathing( caster, true )
        call UnitRemoveAbility( caster, 'A16J' )
        call UnitRemoveAbility( caster, 'A01V' )
        call UnitRemoveAbility( caster, 'B08F' )
        call UnitRemoveAbility( target, 'A04V' )
    	call SaveUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "mdnqtt" ), caster )
    	call DestroyLightning( l )
    	if not( RectContainsUnit( udg_Boss_Rect, caster) ) and udg_combatlogic[GetPlayerId(GetOwningPlayer( caster )) + 1] then
        	call SetUnitPositionLoc( caster, GetRectCenter( udg_Boss_Rect ) )
    	endif
        call FlushChildHashtable( udg_hash, id )
        call DestroyTimer( GetExpiredTimer() )
    endif
    
    set caster = null
    set target = null
    set l = null
endfunction

function MaidenQStart takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "mdnq1" ) )
    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "mdnq1t" ) )
    local lightning l
    local integer lvl = LoadInteger( udg_hash, id, StringHash( "mdnq1" ) )
    local integer id1

	call SetUnitPathing( caster, false )
    call UnitAddAbility( target, 'A16I' )
    call UnitAddAbility( caster, 'A16J' )
    call UnitAddAbility( caster, 'A01V' )
    call UnitAddAbility( target, 'A04V' )
    call SetUnitAbilityLevel( target, 'A04V', lvl )

	set l = AddLightningEx("HWPB", true, GetUnitX(caster), GetUnitY(caster), GetUnitFlyHeight(caster) , GetUnitX(target), GetUnitY(target), GetUnitFlyHeight(target))

    set id1 = GetHandleId( target )
    if LoadTimerHandle( udg_hash, id1, StringHash( "mdnq" ) ) == null  then
        call SaveTimerHandle( udg_hash, id1, StringHash( "mdnq" ), CreateTimer() )
    endif
    set id1 = GetHandleId( LoadTimerHandle( udg_hash, id1, StringHash( "mdnq" ) ) ) 
    call SaveUnitHandle( udg_hash, id1, StringHash( "mdnq" ), caster )
    call SaveUnitHandle( udg_hash, id1, StringHash( "mdnqt" ), target )
	call SaveUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "mdnqtt" ), target )
    call SaveLightningHandle( udg_hash, GetHandleId( target ), StringHash( "mdnql" ), l )
    call SaveInteger(udg_hash, id1, StringHash( "mdnqp" ), udg_Pattern)
    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( target ), StringHash( "mdnq" ) ), 0.02, true, function MaidenQMove )

	call DestroyTimer( GetExpiredTimer() )

	set caster = null
	set target = null
    set l = null
endfunction

function Trig_MaidenQ_Actions takes nothing returns nothing
    local integer id 
    local unit caster
    local unit target
    local integer lvl
    local unit currentBindedUnit
    local boolean isTargetNotOldTarget = true
    
    if CastLogic() then
        set caster = udg_Caster
        set target = udg_Target
        set lvl = udg_Level
    elseif RandomLogic() then
        set caster = udg_Caster
        set target = randomtarget( caster, 900, "ally", RT_HERO, RT_NOT_CASTER, RT_VULNERABLE )
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName('A16G'), caster, 64, 90, 10, 1.5 )
        if target == null then
            set caster = null
            return
        endif
    else
        set caster = GetSpellAbilityUnit()
        set target = GetSpellTargetUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    endif

	set currentBindedUnit = LoadUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "mdnqtt" ) )
	if currentBindedUnit == target then
		set isTargetNotOldTarget = false
	endif
    call dummyspawn( caster, 1, 0, 0, 0 )
	call SaveUnitHandle( udg_hash, GetHandleId( caster ), StringHash( "mdnqtt" ), bj_lastCreatedUnit )
    if currentBindedUnit != null then
        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( currentBindedUnit ), StringHash( "mdnq" ) ), 0.01, false, function MaidenQMove )
    endif

    if isTargetNotOldTarget and caster != target and IsUnitAlly( target, GetOwningPlayer( caster ) ) and IsUnitType( target, UNIT_TYPE_HERO) and target != null then
    	set id = GetHandleId( target )
    	if LoadTimerHandle( udg_hash, id, StringHash( "mdnq1" ) ) == null  then
    		call SaveTimerHandle( udg_hash, id, StringHash( "mdnq1" ), CreateTimer() )
    	endif
    	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "mdnq1" ) ) ) 
    	call SaveUnitHandle( udg_hash, id, StringHash( "mdnq1" ), caster )
    	call SaveUnitHandle( udg_hash, id, StringHash( "mdnq1t" ), target )
    	call SaveInteger( udg_hash, id, StringHash( "mdnq1" ), lvl )
    	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( target ), StringHash( "mdnq1" ) ), 0.01, false, function MaidenQStart )
    endif  

    set caster = null
    set target = null
    set currentBindedUnit = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_MaidenQ = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_MaidenQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_MaidenQ, Condition( function Trig_MaidenQ_Conditions ) )
    call TriggerAddAction( trg_MaidenQ, function Trig_MaidenQ_Actions )
endfunction

endscope
