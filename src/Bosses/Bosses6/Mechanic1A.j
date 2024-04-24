scope Mechanic1A initializer init

    globals
        public constant integer ID_BOSS = 'h010'
        
        private constant integer DAMAGE = 45
        private constant integer SCATTER = 400
        private constant real AREA = 150
        private constant integer EXPLODE_DELAY = 1
        private constant integer EXPLODE_COOLDOWN = 6
        private constant integer TICKS = 8
        
        private constant real DAMAGE_TICK = 0.5
        
        private constant string FIRE_ANIMATION = "Abilities\\Spells\\Human\\FlameStrike\\FlameStrike1.mdl"
        
        trigger trig_Mechanic1A = null
    endglobals

    private function condition takes nothing returns boolean
        return GetUnitTypeId(udg_DamageEventTarget) == ID_BOSS
    endfunction
    
    private function DealDamage takes effect area, integer id returns nothing
        local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "mechanic_firestorm_caster" ) )
        local real damage = LoadReal( udg_hash, id, StringHash( "mechanic_firestorm_damage" ) )
        local group g = CreateGroup()
        local unit u
    
        call GroupEnumUnitsInRange( g, BlzGetLocalSpecialEffectX( area ), BlzGetLocalSpecialEffectY( area ), AREA, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, boss, TARGET_ENEMY ) then
                call UnitTakeDamage(boss, u, damage, DAMAGE_TYPE_MAGIC)
            endif
            call GroupRemoveUnit(g,u)
        endloop
    
        call DestroyGroup( g )
        set u = null
        set g = null
        set area = null
    endfunction

    private function CastFire takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer( ) )
        local effect area = LoadEffectHandle(udg_hash, id, StringHash( "mechanic_firestorm" ) )
        local integer counter = LoadInteger( udg_hash, id, StringHash( "mechanic_fire_counter" ) ) + 1
        
        if counter >= TICKS or area == null then
            call DestroyEffect(area)
            call DestroyTimer( GetExpiredTimer() )
        else
            call DealDamage(area, id)
            call SaveInteger( udg_hash, id, StringHash( "mechanic_fire_counter" ), counter )
        endif
        
        set area = null
    endfunction

    private function DelayEnd takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer( ) )
        local effect area = LoadEffectHandle(udg_hash, id, StringHash( "mechanic_fire_delay" ) )
        local unit caster = LoadUnitHandle(udg_hash, id, StringHash( "mechanic_fire_delay_caster" ) )
        local real damage = LoadReal( udg_hash, id, StringHash( "mechanic_fire_delay_damage" ) )
        local effect fire
        local integer id1
        
        if IsUnitAlive(caster) then
        	call IndicatorSystem_Create( INDICATOR_AIM, BlzGetLocalSpecialEffectX( area ), BlzGetLocalSpecialEffectY( area ), AREA, DAMAGE_TICK * TICKS )
            set fire = AddSpecialEffect(FIRE_ANIMATION, BlzGetLocalSpecialEffectX( area ), BlzGetLocalSpecialEffectY( area ) )
            call BlzSetSpecialEffectScale( fire, AREA/200 )
            set id1 = InvokeTimerWithEffect(fire, "mechanic_firestorm", EXPLODE_DELAY, true, function CastFire )
            call SaveUnitHandle( udg_hash, id1, StringHash( "mechanic_firestorm_caster" ), caster )
            call SaveReal( udg_hash, id1, StringHash( "mechanic_firestorm_damage" ), damage )
        endif
        call DestroyEffect(area)
        call FlushChildHashtable( udg_hash, id )
        
        set caster = null
        set area = null
        set fire = null
    endfunction

    public function SpawnFireArea takes unit caster, real x, real y, real damage returns nothing
        local integer id
        local effect area = AddSpecialEffect(DEATH_AREA, x, y)
        
        call BlzSetSpecialEffectScale( area, AREA/100 )
        
        set id = InvokeTimerWithEffect(area, "mechanic_fire_delay", EXPLODE_DELAY, false, function DelayEnd )
        call SaveUnitHandle( udg_hash, id, StringHash( "mechanic_fire_delay_caster" ), caster )
        call SaveReal( udg_hash, id, StringHash( "mechanic_fire_delay_damage" ), damage )
        
        set caster = null
        set area = null
    endfunction
        
    private function FirestormCast takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer( ) )
        local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "mechanic_fire" ))
        local unit target 
        
        if IsUnitDead(boss) or not( udg_fightmod[0] ) then
            call FlushChildHashtable( udg_hash, id )
            call DestroyTimer( GetExpiredTimer() )
        else
            set target = DeathSystem_GetRandomAliveHero()
            if target != null then
                call SpawnFireArea(boss, GetUnitX( target ), GetUnitY( target ), DAMAGE )
            endif
        endif
        
        set target = null
        set boss = null
    endfunction

    private function action takes nothing returns nothing
        call DisableTrigger( GetTriggeringTrigger() )
        call InvokeTimerWithUnit(udg_DamageEventTarget, "mechanic_fire", bosscast(EXPLODE_COOLDOWN), true, function FirestormCast )
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set trig_Mechanic1A = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
        call DisableTrigger( trig_Mechanic1A )
    endfunction

endscope