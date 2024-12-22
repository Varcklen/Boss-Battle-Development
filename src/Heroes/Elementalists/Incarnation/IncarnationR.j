scope IncarnationR initializer init

    globals
		trigger trg_IncarnationR = null
    endglobals
    
function Trig_IncarnationR_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0V0' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
endfunction

function IncarnationRAoE takes unit caster, unit dummy, real x, real y, real dmg, real area, string who, group h returns nothing
    local group g = CreateGroup()
    local unit u
    
    call GroupEnumUnitsInRange( g, x, y, area, null )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, caster, who ) and not(IsUnitInGroup(u, h)) then
            call UnitDamageTarget( caster, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
            call GroupAddUnit(h,u)
        endif
        call GroupRemoveUnit(g,u)
    endloop
    
    call GroupClear( g )
    call DestroyGroup( g )
    set u = null
    set g = null
    set caster = null
    set dummy = null
    set h = null
endfunction
  
function IncarnationRCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
	local integer sk = LoadInteger( udg_hash, id, StringHash( "incrsk" ) )
	local integer lvl = LoadInteger( udg_hash, id, StringHash( "incrlvl" ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "incr" ) )
    local integer count = LoadInteger( udg_hash, id, StringHash( "incrc" ) ) + 1
    local real dmgrift = LoadReal( udg_hash, id, StringHash( "incrf" ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "incr" ) )
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "incrd" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "incrx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "incry" ) )
    local real xc = GetUnitX( caster )
    local real yc = GetUnitY( caster )
    local real angle = Atan2( y - yc, x - xc )
    local real NewX = xc + 20 * Cos( angle )
    local real NewY = yc + 20 * Sin( angle )
    local real IfX = ( x - xc ) * ( x - xc )
    local real IfY = ( y - yc ) * ( y - yc )
	local group h = LoadGroupHandle( udg_hash, id, StringHash( "incrg" ) )
    local group aoe
    
    if SquareRoot( IfX + IfY ) > 50 and GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 and combat( caster, false, 0 ) and GetUnitAbilityLevel(caster, 'A16J') == 0 then
        call SetUnitPosition( caster, NewX, NewY )
        if count >= 5 then
            call IncarnationRAoE(caster, dummy, NewX, NewY, dmg, 142, "enemy", h)
            set count = 0
        endif
		call SaveGroupHandle( udg_hash, id, StringHash( "incrg" ), h )
        call SaveInteger( udg_hash, id, StringHash( "incrc" ), count )
    else
		if GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 then
            call IncarnationRift( caster, xc, yc, dmgrift)
		endif
		call DestroyEffect( AddSpecialEffect( "war3mapImported\\Soul Discharge Purple.mdx", GetUnitX(caster), GetUnitY(caster) ) )
		call SetUnitSkin( caster, sk )
        call SetUnitPathing( caster, true )
        call UnitRemoveAbility( caster, 'Avul' )
        call PauseUnit( caster, false )
        call RemoveUnit( dummy )
        call FlushChildHashtable( udg_hash, id )
        call DestroyTimer( GetExpiredTimer() )
    endif
    
    set aoe = null
	set h = null
    set caster = null
endfunction

function Trig_IncarnationR_Actions takes nothing returns nothing
    local integer id 
    local integer lvl
    local unit caster
    local unit target
    local real dmg
	local real dmgr
    local real dmgrift
    local real x
    local real y
    local real dist
    local real angle
	local integer sk
	local group g = CreateGroup()
    local unit u
    local integer i
    
    if CastLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
		set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    elseif RandomLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName('A0V0'), caster, 64, 90, 10, 1.5 )
        set dist = GetRandomReal( 0, 730 )
        set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        set x = GetUnitX( caster ) + dist * Cos( angle )
        set y = GetUnitY( caster ) + dist * Sin( angle )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
		set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    endif

	call DestroyEffect( AddSpecialEffect( "war3mapImported\\Soul Discharge Purple.mdx", GetUnitX(caster), GetUnitY(caster) ) )
	set dmgrift = ( 5 + ( 5 * lvl ) ) * GetUnitSpellPower(caster)

    call IncarnationRift( caster, GetUnitX( caster ), GetUnitY( caster ), dmgrift)

    if udg_combatlogic[GetPlayerId(GetOwningPlayer( caster )) + 1] and not( RectContainsLoc(udg_Boss_Rect, Location(x, y) ) ) then
        set caster = null
        set target = null
        return
    endif

    set id = GetHandleId( caster )
    set dmg = (65 + ( 35 * lvl )) * GetUnitSpellPower(caster)
	set dmgr = dmg
	
	set bj_livingPlayerUnitsTypeId = 'u000'
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer( caster ), filterLivingPlayerUnitsOfTypeId)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
		if GetUnitAbilityLevel( u, 'A0UC') > 0 then
			set dmg = dmg + (dmgr*0.1)
		endif
        call GroupRemoveUnit(g,u)
    endloop
    
	//set i = GetPlayerId( GetOwningPlayer(caster) ) + 1
    set i = CorrectPlayer(caster)
    if udg_SkinUsed[i] != 0 then
        set sk = udg_SkinUsed[i]
    else
        set sk = GetUnitTypeId( caster )
    endif
	call SetUnitSkin( caster, 'u00Y' )
	
    call PauseUnit( caster, true )
	call UnitAddAbility( caster, 'Avul' )
    
    call dummyspawn( caster, 0, 'A0N5', 0, 0 )
    call SetUnitPathing( caster, false )
    call SetUnitFacing( caster, bj_RADTODEG * Atan2(y - GetUnitY(caster), x - GetUnitX(caster) ) )

    if LoadTimerHandle( udg_hash, id, StringHash( "incr" ) ) == null  then
    	call SaveTimerHandle( udg_hash, id, StringHash( "incr" ), CreateTimer() )
    endif
    set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "incr" ) ) ) 
    call SaveUnitHandle( udg_hash, id, StringHash( "incr" ), caster )
    call SaveUnitHandle( udg_hash, id, StringHash( "incrd" ), bj_lastCreatedUnit )
	call SaveReal( udg_hash, id, StringHash( "incrx" ), x )
	call SaveReal( udg_hash, id, StringHash( "incry" ), y )
    call SaveReal( udg_hash, id, StringHash( "incr" ), dmg )
    call SaveReal( udg_hash, id, StringHash( "incrf" ), dmgrift )
	call SaveInteger( udg_hash, id, StringHash( "incrsk" ), sk )
	call SaveInteger( udg_hash, id, StringHash( "incrlvl" ), lvl )
	call SaveGroupHandle( udg_hash, id, StringHash( "incrg" ), CreateGroup() )
    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "incr" ) ), 0.02, true, function IncarnationRCast )

	call SetUnitState( caster, UNIT_STATE_LIFE, RMaxBJ(10,GetUnitState( caster, UNIT_STATE_LIFE) - ( GetUnitState( caster, UNIT_STATE_MAX_LIFE) * (0.2 - (0.02*lvl) ) ) ) )

	call GroupClear( g )
    call DestroyGroup( g )
    set u = null
	set g = null
    set caster = null
    set target = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_IncarnationR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_IncarnationR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_IncarnationR, Condition( function Trig_IncarnationR_Conditions ) )
    call TriggerAddAction( trg_IncarnationR, function Trig_IncarnationR_Actions )
endfunction

endscope

