scope WandererW initializer init

    globals
    	private constant integer ABILITY_ID = 'A0JG'
	
		private constant integer DAMAGE_BASE = 5
		private constant integer DAMAGE_SCALE = 5
		
		private constant integer SHIELD_BASE = 50
		private constant integer SHIELD_SCALE = 20
		private constant integer SHIELD_RANGE = 110
		
		private constant integer DURATION_BASE = 8
		
		private constant integer HP_COST = 50
		
		trigger trg_WandererW = null
    endglobals

function Trig_WandererW_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == ABILITY_ID
endfunction

function WandererWWawe takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local integer counter = LoadInteger( udg_hash, id, StringHash( "wndww" ) ) 
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "wndww" ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "wndwwcs" ) )
    local unit u
    local real NewX = GetUnitX( dummy ) + 20 * Cos( 0.017 * GetUnitFacing( dummy ) )
    local real NewY = GetUnitY( dummy ) + 20 * Sin( 0.017 * GetUnitFacing( dummy ) )
    local real sh = LoadReal( udg_hash, id, StringHash( "wndww" ) )
    local group nodmg = LoadGroupHandle( udg_hash, GetHandleId( dummy ), StringHash( "wndwwg" ) )
    local group g = CreateGroup()

    if counter >= 50 or GetUnitState( dummy, UNIT_STATE_LIFE) <= 0.405 then
        call RemoveUnit( dummy )
        call GroupClear( nodmg )
        call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl", GetUnitX(dummy), GetUnitY(dummy)) )
        call SaveGroupHandle( udg_hash, GetHandleId( dummy ), StringHash( "wndwwg" ), nodmg )
        call DestroyGroup( nodmg )
        call FlushChildHashtable( udg_hash, id )
        call DestroyTimer( GetExpiredTimer() )
    else
        call SetUnitPosition( dummy, NewX, NewY )
        call SaveInteger( udg_hash, id, StringHash( "wndww" ), counter + 1)
        call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), SHIELD_RANGE, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, "ally" ) and not( IsUnitInGroup( u, nodmg ) ) then
				call shield( caster, u, sh )
                call GroupAddUnit( nodmg, u )
            endif
            call GroupRemoveUnit(g,u)
        endloop
        call SaveGroupHandle( udg_hash, GetHandleId( dummy ), StringHash( "wndwwg" ), nodmg )
    endif
    
    call DestroyGroup( g )
    set u = null
    set g = null
    set dummy = null
    set caster = null
endfunction

function WandererWCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local real counter = LoadReal( udg_hash, id, StringHash( "wndw2" ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "wndw" ) )
    local real sh = LoadReal( udg_hash, id, StringHash( "wndws" ) )
    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "wndw" ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "wndwc" ) )
    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "wndw1" ) )
    local integer id1
    local integer cyclA
    
    if GetUnitState( target, UNIT_STATE_LIFE) > 0.405 then
        call UnitDamageTarget( dummy, target, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
    endif
    
    if GetUnitAbilityLevel( target, 'B01T') > 0 then 
    	if GetUnitState(target, UNIT_STATE_LIFE) > 0.405 and counter > 0 then
        	call SaveReal( udg_hash, id, StringHash( "wndw2" ), counter - 1 )
    	else
        	set cyclA = 1
            loop
                exitwhen cyclA > 6
                set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'u000', GetUnitX( target ), GetUnitY( target ), 60 * cyclA )
                call UnitAddAbility( bj_lastCreatedUnit, 'A0LC')
                
                set id1 = GetHandleId( bj_lastCreatedUnit )
                call SaveTimerHandle( udg_hash, id1, StringHash( "wndww" ), CreateTimer() )
                set id1 = GetHandleId( LoadTimerHandle( udg_hash, id1, StringHash( "wndww" ) ) ) 
                call SaveUnitHandle( udg_hash, id1, StringHash( "wndww" ), bj_lastCreatedUnit )
                call SaveUnitHandle( udg_hash, id1, StringHash( "wndwwcs" ), caster )
                call SaveReal( udg_hash, id1, StringHash( "wndww" ), sh )
                call SaveGroupHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "wndwwg" ), CreateGroup() )
                call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "wndww" ) ), 0.04, true, function WandererWWawe )
                set cyclA = cyclA + 1
            endloop
            call UnitRemoveAbility( target, 'A0LB' )
        	call UnitRemoveAbility( target, 'B01T' )
	        call RemoveUnit( dummy )
	        call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
    	endif
	else
        call UnitRemoveAbility( target, 'A0LB' )
        call UnitRemoveAbility( target, 'B01T' )
        call RemoveUnit( dummy )
        call DestroyTimer( GetExpiredTimer() )
        call FlushChildHashtable( udg_hash, id )
    endif
    
    set target = null
    set caster = null
    set dummy = null
endfunction

function Trig_WandererW_Actions takes nothing returns nothing
    local unit dummy
    local integer id
    local real dmg
    local real sh
    local integer stack
    local unit caster
    local unit target
    local integer lvl
    local real t
    local boolean l = false
    
    if CastLogic() then
        set caster = udg_Caster
        set target = udg_Target
        set lvl = udg_Level
        set t = udg_Time
    elseif RandomLogic() then
        set caster = udg_Caster
        set target = randomtarget( caster, 900, "enemy", 0, 0, 0 )
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName('A0JG'), caster, 64, 90, 10, 1.5 )
        set t = DURATION_BASE - lvl
        if target == null then
            set caster = null
            return
        endif
    else
        set caster = GetSpellAbilityUnit()
        set target = GetSpellTargetUnit()
        set lvl = GetUnitAbilityLevel(caster, ABILITY_ID)
        set t = DURATION_BASE - lvl
    endif
    set t = timebonus(caster, t)

    call UnitAddAbility( target, 'A0LB')
    set dmg = ( DAMAGE_BASE + ( DAMAGE_SCALE * lvl ) ) //* GetUnitSpellPower(caster)
    set sh = SHIELD_BASE + ( SHIELD_SCALE * lvl )
    
    call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl", target, "origin") )
    
    set id = GetHandleId( target )
    if LoadTimerHandle( udg_hash, id, StringHash( "wndw" ) ) == null then
        call SaveTimerHandle( udg_hash, id, StringHash( "wndw" ), CreateTimer() )
        set l = true
    endif
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "wndw" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "wndw" ), target )
    call SaveUnitHandle( udg_hash, id, StringHash( "wndwc" ), caster )
    call SaveReal( udg_hash, id, StringHash( "wndw2" ), t )
    call SaveReal( udg_hash, id, StringHash( "wndw" ), dmg )
    call SaveReal( udg_hash, id, StringHash( "wndws" ), sh )
    if l then
        call dummyspawn( caster, 0, 0, 0, 0 )
        call SaveUnitHandle( udg_hash, id, StringHash( "wndw1" ), bj_lastCreatedUnit )
    endif
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( target ), StringHash( "wndw" ) ), 1, true, function WandererWCast )
    
    call SetUnitState( caster, UNIT_STATE_LIFE, RMaxBJ(0,GetUnitState( caster, UNIT_STATE_LIFE) - HP_COST ))
    
    set dummy = null
    set caster = null
    set target = null
endfunction

//===========================================================================
//===========================================================================
private function init takes nothing returns nothing
    set trg_WandererW = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_WandererW, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_WandererW, Condition( function Trig_WandererW_Conditions ) )
    call TriggerAddAction( trg_WandererW, function Trig_WandererW_Actions )
endfunction

endscope

