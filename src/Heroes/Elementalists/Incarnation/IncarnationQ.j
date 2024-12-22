function Trig_IncarnationQ_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0U7' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
endfunction

function IncarnationQCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local integer counter = LoadInteger( udg_hash, id, StringHash( "incq" ) )
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "incq1" ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "incq" ) )
    local group g = CreateGroup()
    local unit u
    local real dmg = LoadReal( udg_hash, id, StringHash( "incq" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "incqx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "incqy" ) )

    call GroupEnumUnitsInRange( g, x, y, 142, null )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, caster, "enemy" ) then
            call UnitDamageTarget( dummy, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
        endif
        call GroupRemoveUnit(g,u)
    endloop
    
    if counter > 0 and GetUnitState( dummy, UNIT_STATE_LIFE) > 0.405 then
        call SaveInteger( udg_hash, id, StringHash( "incq" ), counter - 1 )
    else
        call RemoveUnit( dummy )
        call DestroyTimer( GetExpiredTimer() )
        call FlushChildHashtable( udg_hash, id ) 
    endif
    
    call GroupClear( g )
    call DestroyGroup( g )
    set u = null
	set g = null
    set dummy = null
    set caster = null
endfunction

function IncarnationQRushEnd takes unit caster, integer sk, integer id, timer t returns nothing
    call DestroyEffect( AddSpecialEffect( "war3mapImported\\Soul Discharge Purple.mdx", GetUnitX(caster), GetUnitY(caster) ) )
    call SetUnitSkin( caster, sk )
    call SetUnitPathing( caster, true )
    call PauseUnit( caster, false )
    call UnitRemoveAbility( caster, 'Avul' )
    call FlushChildHashtable( udg_hash, id )
    call DestroyTimer( t )

    set caster = null
    set t = null
endfunction

function IncarnationQRush takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local integer counter = LoadInteger( udg_hash, id, StringHash( "incqr" ) )
	local integer c = LoadInteger( udg_hash, id, StringHash( "incqrc" ) ) + 1
	local integer sk = LoadInteger( udg_hash, id, StringHash( "incqrsk" ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "incqr" ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "incqr" ) )
    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "incqrt" ) )
    local real x = GetUnitX( target )
    local real y = GetUnitY( target )
    local real xc = GetUnitX( caster )
    local real yc = GetUnitY( caster )
    local real angle = Atan2( y - yc, x - xc )
    local real NewX = xc + 30 * Cos( angle )
    local real NewY = yc + 30 * Sin( angle )
    local real IfX = ( x - xc ) * ( x - xc )
    local real IfY = ( y - yc ) * ( y - yc )
	local group h = LoadGroupHandle( udg_hash, id, StringHash( "incqrg" ) )
    
	if GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 then
		if c >= 12 then
			call SaveInteger( udg_hash, id, StringHash( "incqrc" ), 0 )
            call GroupAoE( caster, xc, yc, dmg, 142, "enemy", "", "" )
            /*
			call GroupEnumUnitsInRange( g, xc, yc, 142, null )
			loop
				set u = FirstOfGroup(g)
				exitwhen u == null
				if unitst( u, caster, "enemy" ) then
					call UnitDamageTarget( caster, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
				endif
				call GroupRemoveUnit(g,u)
			endloop*/
		else
			call SaveInteger( udg_hash, id, StringHash( "incqrc" ), c )
		endif
	endif
	if counter < 500 and GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 and GetUnitAbilityLevel(caster, 'A17U') == 0 then
        if SquareRoot( IfX + IfY ) > 50 and GetUnitState( target, UNIT_STATE_LIFE) > 0.405 then
            call SetUnitPosition( caster, NewX, NewY )
        else
            set target = GroupPickRandomUnit(h)
            if target == null then
                call IncarnationQRushEnd(caster, sk, id, GetExpiredTimer())
            else
                call GroupRemoveUnit(h,target)
                call SaveUnitHandle( udg_hash, id, StringHash( "incqrt" ), target )
                call SaveGroupHandle( udg_hash, id, StringHash( "incqrg" ), h )
            endif
        endif
        call SaveInteger( udg_hash, id, StringHash( "incqr" ), counter + 1 )
	else
		call IncarnationQRushEnd(caster, sk, id, GetExpiredTimer())
    endif
    
	set h = null
    set caster = null
    set target = null
endfunction

function IncarnationRift takes unit u, real x, real y, real dmg returns nothing
    local integer id 
    
    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( u ), 'u000', x, y, bj_UNIT_FACING )
    call UnitAddAbility( bj_lastCreatedUnit, 'A0UC' )
    set id = GetHandleId( bj_lastCreatedUnit )
    
    call SaveTimerHandle( udg_hash, id, StringHash( "incq" ), CreateTimer() )
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "incq" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "incq" ), u )
    call SaveUnitHandle( udg_hash, id, StringHash( "incq1" ), bj_lastCreatedUnit )
    call SaveInteger( udg_hash, id, StringHash( "incq" ), 30 )
    call SaveReal( udg_hash, id, StringHash( "incq" ), dmg )
    call SaveReal( udg_hash, id, StringHash( "incqx" ), x )
    call SaveReal( udg_hash, id, StringHash( "incqy" ), y )
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "incq" ) ), 1, true, function IncarnationQCast )
    
    set u = null
endfunction

function Trig_IncarnationQ_Actions takes nothing returns nothing
    local integer id 
    local unit caster
    local integer lvl
    local real x
    local real y
    local real dist
    local real angle
    local real dmg
	local group g = CreateGroup()
	local group h = CreateGroup()
    local unit u
	local unit t
	local integer sk
    local integer i
    
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
        call textst( udg_string[0] + GetObjectName('A0U7'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    endif

    set dmg = ( 15 + ( 5 * lvl ) ) * GetUnitSpellPower(caster)

	call DestroyEffect( AddSpecialEffect( "war3mapImported\\Soul Discharge Purple.mdx", GetUnitX(caster), GetUnitY(caster) ) )
	
    call IncarnationRift( caster, x, y, dmg)
    
	set bj_livingPlayerUnitsTypeId = 'u000'
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer( caster ), filterLivingPlayerUnitsOfTypeId)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
		if GetUnitAbilityLevel( u, 'A0UC') > 0 then
			call GroupAddUnitSimple( u, h )
		endif
        call GroupRemoveUnit(g,u)
    endloop
	
	set t = GroupPickRandomUnit(h)
	call GroupRemoveUnit(h,t)
    
    call PauseUnit( caster, true )
    
    call SetUnitPathing( caster, false )
	call UnitAddAbility( caster, 'Avul' )
	
    //set i = GetPlayerId( GetOwningPlayer(caster) ) + 1
    set i = GetUnitUserData(caster)
    if udg_SkinUsed[i] != 0 then
        set sk = udg_SkinUsed[i]
    else
        set sk = GetUnitTypeId( caster )
    endif
	
	call SetUnitSkin( caster, 'u00Y' )

    set id = GetHandleId( caster )
    if LoadTimerHandle( udg_hash, id, StringHash( "incqr" ) ) == null  then
    	call SaveTimerHandle( udg_hash, id, StringHash( "incqr" ), CreateTimer() )
    endif
    set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "incqr" ) ) ) 
    call SaveUnitHandle( udg_hash, id, StringHash( "incqr" ), caster )
    call SaveUnitHandle( udg_hash, id, StringHash( "incqrt" ), t )
	call SaveGroupHandle( udg_hash, id, StringHash( "incqrg" ), h )
    call SaveReal( udg_hash, id, StringHash( "incqr" ), dmg )
	call SaveInteger( udg_hash, id, StringHash( "incqrsk" ), sk )
    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "incqr" ) ), 0.02, true, function IncarnationQRush )
	
	call SetUnitState( caster, UNIT_STATE_LIFE, RMaxBJ(10,GetUnitState( caster, UNIT_STATE_LIFE) - ( GetUnitState( caster, UNIT_STATE_MAX_LIFE) * (0.22 - (0.02*lvl) ) ) ) )
	
	call GroupClear( g )
    call DestroyGroup( g )
	set t = null
    set h = null
    set u = null
    set g = null
    set caster = null
endfunction

//===========================================================================
function InitTrig_IncarnationQ takes nothing returns nothing
    set gg_trg_IncarnationQ = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_IncarnationQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_IncarnationQ, Condition( function Trig_IncarnationQ_Conditions ) )
    call TriggerAddAction( gg_trg_IncarnationQ, function Trig_IncarnationQ_Actions )
endfunction

