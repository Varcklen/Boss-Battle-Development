scope PredatorW initializer init

    globals
		trigger trg_PredatorW = null
    endglobals
    
function Trig_PredatorW_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A15N' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
endfunction
  
function PredatorWEnd takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "prdw1" ) )
    call UnitRemoveAbility( u, 'A15P' )
    call UnitRemoveAbility( u, 'B072' )
    call FlushChildHashtable( udg_hash, id )

    set u = null
endfunction

function PredatorWCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local integer id1
	local integer lvl = LoadInteger( udg_hash, id, StringHash( "prdwlvl" ) )
	local integer count = LoadInteger( udg_hash, id, StringHash( "prdw" ) ) + 1
    local real dmg = LoadReal( udg_hash, id, StringHash( "prdw" ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "prdw" ) )
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "prdwd" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "prdwx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "prdwy" ) )
    local real reduce = LoadReal( udg_hash, id, StringHash( "prdwr" ) )
    local real xc = GetUnitX( caster )
    local real yc = GetUnitY( caster )
    local real angle = Atan2( y - yc, x - xc )
    local real NewX = xc + 20 * Cos( angle )
    local real NewY = yc + 20 * Sin( angle )
    local real IfX = ( x - xc ) * ( x - xc )
    local real IfY = ( y - yc ) * ( y - yc )
	local group h = LoadGroupHandle( udg_hash, id, StringHash( "prdwg" ) )
	local group g = CreateGroup()
    local unit u
    
    if RectContainsCoords(udg_Boss_Rect, x, y) and count < 200 and SquareRoot( IfX + IfY ) > 50 and GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 and combat( caster, false, 0 ) and GetUnitAbilityLevel(caster, 'A16J') == 0  and GetUnitAbilityLevel(caster, 'A17U') == 0 then
        call SaveInteger( udg_hash, id, StringHash( "prdw" ), count )
		call SetUnitPosition( caster, NewX, NewY )
		call GroupEnumUnitsInRange( g, NewX, NewY, 142, null )
		loop
			set u = FirstOfGroup(g)
			exitwhen u == null
			if unitst( u, caster, "enemy" ) and not(IsUnitInGroup(u, h)) then
				call UnitDamageTarget( caster, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
				call GroupAddUnit(h,u)
			endif
			call GroupRemoveUnit(g,u)
		endloop
		call SaveGroupHandle( udg_hash, id, StringHash( "prdwg" ), h )
    else
    	call UnitAddAbility( caster, 'A15P' )
    
        set id1 = GetHandleId( caster )
        if LoadTimerHandle( udg_hash, id, StringHash( "prdw1" ) ) == null  then
            call SaveTimerHandle( udg_hash, id1, StringHash( "prdw1" ), CreateTimer() )
        endif
        set id1 = GetHandleId( LoadTimerHandle( udg_hash, id1, StringHash( "prdw1" ) ) ) 
        call SaveUnitHandle( udg_hash, id1, StringHash( "prdw1" ), caster )
        call SaveReal( udg_hash, GetHandleId( caster ), StringHash( "prdw1" ), reduce )
        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "prdw1" ) ), 15, false, function PredatorWEnd )
   
    	call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", GetUnitX(caster), GetUnitY(caster) ) )
        call SetUnitPathing( caster, true )
        call UnitRemoveAbility( caster, 'Avul' )
        call PauseUnit( caster, false )
    	call pausest( caster, -1 )
        call UnitRemoveAbility( caster, 'A0DV' )
        call RemoveUnit( dummy )
        call FlushChildHashtable( udg_hash, id )
        call DestroyTimer( GetExpiredTimer() )
    endif
    
    call DestroyGroup( g )
    set u = null
	set g = null
	set h = null
    set caster = null
endfunction

function Trig_PredatorW_Actions takes nothing returns nothing
    local integer id 
    local integer lvl
    local unit caster
    local unit target
    local real dmg
    local real x
    local real y
    local real dist 
    local real angle 
    local real reduce
    
    if CastLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
		set x = GetSpellTargetX()
        set y = GetSpellTargetY()
    elseif RandomLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName('A15N'), caster, 64, 90, 10, 1.5 )
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

    if udg_combatlogic[GetPlayerId(GetOwningPlayer( caster )) + 1] and not( RectContainsCoords(udg_Boss_Rect, x, y) ) then
        set caster = null
        set target = null
        return
    endif

    set id = GetHandleId( caster )
    set dmg = (80 + ( 40 * lvl )) * GetUnitSpellPower(caster)
    set reduce = (0.05*lvl)+0.04
    
    if GetUnitAbilityLevel( caster, 'A0DV' ) == 0 then
            call pausest( caster, 1 )
    endif
	call UnitAddAbility( caster, 'Avul' )
    call UnitAddAbility( caster, 'A0DV' )
    
    call dummyspawn( caster, 0, 'A0N5', 0, 0 )
    call SetUnitPathing( caster, false )
    call SetUnitFacing( caster, bj_RADTODEG * Atan2(y - GetUnitY(caster), x - GetUnitX(caster) ) )

    	if LoadTimerHandle( udg_hash, id, StringHash( "prdw" ) ) == null  then
    		call SaveTimerHandle( udg_hash, id, StringHash( "prdw" ), CreateTimer() )
   	endif
    	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "prdw" ) ) ) 
    	call SaveUnitHandle( udg_hash, id, StringHash( "prdw" ), caster )
    	call SaveUnitHandle( udg_hash, id, StringHash( "prdwd" ), bj_lastCreatedUnit )
	call SaveReal( udg_hash, id, StringHash( "prdwx" ), x )
	call SaveReal( udg_hash, id, StringHash( "prdwy" ), y )
    	call SaveReal( udg_hash, id, StringHash( "prdw" ), dmg )
    	call SaveReal( udg_hash, id, StringHash( "prdwr" ), reduce )
	call SaveInteger( udg_hash, id, StringHash( "prdwlvl" ), lvl )
	call SaveGroupHandle( udg_hash, id, StringHash( "prdwg" ), CreateGroup() )
    	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "prdw" ) ), 0.02, true, function PredatorWCast )

    set caster = null
    set target = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_PredatorW = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_PredatorW, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_PredatorW, Condition( function Trig_PredatorW_Conditions ) )
    call TriggerAddAction( trg_PredatorW, function Trig_PredatorW_Actions )
endfunction

endscope

