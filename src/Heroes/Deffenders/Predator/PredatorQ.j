scope PredatorQ initializer init

    globals
    	private constant integer ABILITY_ID = 'A15M'
	
		private constant integer DAMAGE_BASE = 140
		private constant integer DAMAGE_SCALE = 40
		
		private constant integer HEAL_BASE = 30
		private constant integer HEAL_SCALE = 10
		
		private constant integer KNOCK_BASE = 35
		private constant integer KNOCK_SCALE = 0
		
		private constant integer AREA = 350
		private constant integer FRONT_RANGE = 250
		
		trigger trg_PredatorQ = null
    endglobals

function Trig_PredatorQ_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == ABILITY_ID and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
endfunction

function PredatorQRun takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "prdqc" ) )
    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "prdq" ) )
    local integer counter = LoadInteger( udg_hash, id, StringHash( "prdq" ) ) + 1
    local integer lvl = LoadInteger( udg_hash, id, StringHash( "prdql" ) )
    local integer knockback = KNOCK_BASE + KNOCK_SCALE * lvl
    //local real x = LoadReal( udg_hash, id, StringHash( "prdqx" ) )
    //local real y = LoadReal( udg_hash, id, StringHash( "prdqy" ) )
    //local real angle = Atan2( y - GetUnitY( u ), x - GetUnitX( u ) )
    local real angle = LoadReal( udg_hash, id, StringHash( "prdqg" ) )
    local real NewX = GetUnitX( u ) + knockback * Cos( angle )
    local real NewY = GetUnitY( u ) + knockback * Sin( angle )
	local real dmg = LoadReal( udg_hash, id, StringHash( "prdq" ))

    if counter == 8 then
        call SetUnitFlyHeight( u, -600, 1500 )
    endif

    if counter == 16 or GetUnitState( u, UNIT_STATE_LIFE) <= 0.405 then
		call SetUnitFlyHeight( u, 0, 0 )
		call SetUnitPathing( u, true )
		call UnitRemoveAbility( u, 'Amrf' )
        call pausest( u, -1 )
		if GetUnitState( u, UNIT_STATE_LIFE) > 0.405 then
            call UnitDamageTarget( caster, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
        endif
        call DestroyTimer( GetExpiredTimer() )
    else 
        call SaveInteger( udg_hash, id, StringHash( "prdq" ), counter )
        if RectContainsCoords(udg_Boss_Rect, NewX, NewY) then
            call SetUnitPosition( u, NewX, NewY )
        endif
    endif
    
    set caster = null
    set u = null
endfunction

function Trig_PredatorQ_Actions takes nothing returns nothing
    local real x 
    local real y
    local real dmg
    local real heal
    local real heals = 0
    local group g = CreateGroup()
    local unit u
    local integer id 
    local integer lvl
    local unit caster
    local real angle
    //local real NewX
    //local real NewY
    
    if CastLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
    elseif RandomLogic() then
        set caster = udg_Caster
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName('A15M'), caster, 64, 90, 10, 1.5 )
    else
        set caster = GetSpellAbilityUnit()
        set lvl = GetUnitAbilityLevel(caster, ABILITY_ID )
    endif
    
    set x = GetUnitX( caster ) + FRONT_RANGE * Cos( 0.017 * GetUnitFacing( caster ) )
    set y = GetUnitY( caster ) + FRONT_RANGE * Sin( 0.017 * GetUnitFacing( caster ) )
    
    set dmg = DAMAGE_BASE + ( DAMAGE_SCALE * lvl )
    set heal = (HEAL_SCALE * lvl) + HEAL_BASE

    call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", x, y ) )
    call GroupEnumUnitsInRange( g, x, y, AREA, null )
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if unitst( u, caster, TARGET_ENEMY ) then
            set heals = heals + heal
            if GetUnitDefaultMoveSpeed(u) != 0 and LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "prdq" ) ) == null then
                call pausest( u, 1 )
                call UnitAddAbility( u, 'Amrf' )
                call SetUnitFlyHeight( u, 600, 1500 )
                call SetUnitPathing( u, false )
            
                set angle = Atan2( GetUnitY( u ) - GetUnitY( caster ), GetUnitX( u ) - GetUnitX( caster ) )
                //set NewX = GetUnitX( u ) + 900 * Cos( angle )
                //set NewY = GetUnitY( u ) + 900 * Sin( angle )
                
    			//set angle = Atan2( NewY - GetUnitY( u ), NewX - GetUnitX( u ) )
            
                set id = InvokeTimerWithUnit(u, "prdq", 0.02, true, function PredatorQRun )
                call SaveUnitHandle( udg_hash, id, StringHash( "prdqc" ), caster)
                call SaveReal( udg_hash, id, StringHash( "prdq" ), dmg)
                //call SaveReal( udg_hash, id, StringHash( "prdqx" ), NewX )
                //call SaveReal( udg_hash, id, StringHash( "prdqy" ), NewY )
                call SaveReal( udg_hash, id, StringHash( "prdqg" ), angle)
       			call SaveInteger( udg_hash, id, StringHash( "prdql" ), lvl )
            endif
        endif
        call GroupRemoveUnit(g,u)
    endloop

    call healst(caster, null, heals )
    
    call GroupClear( g )
    call DestroyGroup( g )
    set g = null
    set u = null
    set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_PredatorQ = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_PredatorQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_PredatorQ, Condition( function Trig_PredatorQ_Conditions ) )
    call TriggerAddAction( trg_PredatorQ, function Trig_PredatorQ_Actions )
endfunction

endscope

