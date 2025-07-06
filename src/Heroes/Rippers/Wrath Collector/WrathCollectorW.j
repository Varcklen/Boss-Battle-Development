scope WrathCollectorW initializer init

	globals
		private constant integer ABILITY_ID = 'A1GU'
		
		private constant integer AREA = 200
		private constant integer FLY_RANGE = 1200
		private constant real TICK_PERIOD = 0.04
		private constant integer SPEED = R2I(600*TICK_PERIOD)
		
		private constant integer DAMAGE_INITIAL = 125
		private constant integer DAMAGE_PER_LEVEL = 25
		
		private constant real DURATION_INITIAL = 1.25
		private constant real DURATION_PER_LEVEL = 0.25
		private constant integer EFFECT_ID = 'A1GX'
		private constant integer BUFF_ID = 'B0AQ'
		
		private constant string PROJECTILE_TYPE = "Abilities\\Spells\\Orc\\Shockwave\\ShockwaveMissile.mdl"
		
		private constant integer WRATH_BONUS_REQUIRE = 50
		private constant real WRATH_BONUS_MULTIPIER = 2
		
		trigger WrathCollectorW = null
	endglobals

	private function condition takes nothing returns boolean
        return GetSpellAbilityId() == ABILITY_ID
    endfunction
    
    private function DealDamage takes unit caster, effect projectile, integer id, group affectedUnits returns nothing
    	local real area = LoadReal( udg_hash, id, StringHash( "wrath_collector_w_wave_area" ) )
    	local real damage = LoadReal( udg_hash, id, StringHash( "wrath_collector_w_wave_damage" ) )
    	local real duration = LoadReal( udg_hash, id, StringHash( "wrath_collector_w_wave_duration" ) )
    	local group g = CreateGroup()
        local unit u
    
        call GroupEnumUnitsInRange( g, BlzGetLocalSpecialEffectX( projectile ), BlzGetLocalSpecialEffectY( projectile ), area, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, "enemy" ) and IsUnitInGroup( u, affectedUnits ) == false then
                call UnitDamageTarget( caster, u, damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
                call GroupAddUnit( affectedUnits, u )
                call bufallst( caster, u, EFFECT_ID, 0, 0, 0, 0, BUFF_ID, "wrath_collector_w_wave_debuff", duration )
            endif
            call GroupRemoveUnit(g,u)
        endloop
    
        call DestroyGroup( g )
        set g = null
        set affectedUnits = null
        set u = null
        set caster = null
        set projectile = null
    endfunction
    
    private function ProjectileMoving takes nothing returns nothing
    	local integer id = GetHandleId( GetExpiredTimer() )
        local integer counter = 	LoadInteger( udg_hash, id, StringHash( "wrath_collector_w_wave_counter" ) )
        local effect projectile = 	LoadEffectHandle( udg_hash, id, StringHash( "wrath_collector_w_wave" ) )
        local unit caster = 		LoadUnitHandle( udg_hash, id, StringHash( "wrath_collector_w_wave_caster" ) )
        local real angle = 			LoadReal( udg_hash, id, StringHash( "wrath_collector_w_wave_angle" ) )
        local group affectedUnits = LoadGroupHandle( udg_hash, id, StringHash( "wrath_collector_w_wave_affected" ) )
        local location newPoint = 	null

        if counter >= FLY_RANGE or projectile == null then
            call DestroyEffect( projectile )
            call DestroyGroup( affectedUnits )
            call DestroyTimer( GetExpiredTimer() )
        else
            set newPoint = LocationSystem_GetMovedEffect( projectile, angle, SPEED )
            call BlzSetSpecialEffectPositionLoc( projectile, newPoint )
            call DealDamage( caster, projectile, id, affectedUnits )
            call SaveInteger( udg_hash, id, StringHash( "wrath_collector_w_wave_counter" ), counter + SPEED )
        endif

        call RemoveLocation(newPoint)
        set newPoint = null
        set projectile = null
        set caster = null
        set affectedUnits = null
    endfunction
    
    private function StartProjectile takes unit caster, integer level, real x, real y returns nothing
    	local integer id 
    	local effect projectile
        local real angle
        local location casterPoint = GetUnitLoc(caster)
        local location targetPoint = Location(x, y)
        local real damage = DAMAGE_INITIAL + DAMAGE_PER_LEVEL * level
        local real duration = timebonus(caster, DURATION_INITIAL + DURATION_PER_LEVEL * level )
        local real area = AREA
        
        if WrathBarEffect_GetValue(caster) >= WRATH_BONUS_REQUIRE then
        	set damage = damage * WRATH_BONUS_MULTIPIER
        	set area = area * WRATH_BONUS_MULTIPIER
        endif
        
        set projectile = AddSpecialEffectLoc( PROJECTILE_TYPE, casterPoint )
        set angle = AngleBetweenPoints( casterPoint, targetPoint )
        call BlzSetSpecialEffectYaw( projectile, Deg2Rad(angle) )
        call BlzSetSpecialEffectScale( projectile, area / 125.0 )
        
        set id = InvokeTimerWithEffect( projectile, "wrath_collector_w_wave", TICK_PERIOD, true, function ProjectileMoving )
        call SaveUnitHandle( udg_hash, id, StringHash( "wrath_collector_w_wave_caster" ), caster )
        call SaveReal( udg_hash, id, StringHash( "wrath_collector_w_wave_damage" ), damage )
        call SaveReal( udg_hash, id, StringHash( "wrath_collector_w_wave_duration" ), duration )
        call SaveReal( udg_hash, id, StringHash( "wrath_collector_w_wave_area" ), area )
        call SaveReal( udg_hash, id, StringHash( "wrath_collector_w_wave_angle" ), angle )
        call SaveGroupHandle( udg_hash, id, StringHash( "wrath_collector_w_wave_affected" ), CreateGroup() )
        
        call RemoveLocation(casterPoint)
        call RemoveLocation(targetPoint)
        set casterPoint = null
        set targetPoint = null
    endfunction
    
    private function action takes nothing returns nothing
        local integer lvl
        local unit caster
        local real x
        local real y
        
        if CastLogic() then
            set caster = udg_Caster
            set x = GetSpellTargetX()
        	set y = GetSpellTargetY()
            set lvl = udg_Level
        elseif RandomLogic() then
            set caster = udg_Caster
            set x = GetUnitX( caster ) + GetRandomReal( -650, 650 )
        	set y = GetUnitY( caster ) + GetRandomReal( -650, 650 )
            set lvl = udg_Level
            call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())
            set x = GetSpellTargetX()
        	set y = GetSpellTargetY()
        endif
        
        call StartProjectile(caster, lvl, x, y)
        
        set caster = null
    endfunction

	//===========================================================================
    private function init takes nothing returns nothing
    	set WrathCollectorW = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
    endfunction

endscope