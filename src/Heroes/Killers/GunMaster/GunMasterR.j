scope GunMasterR initializer init

    globals
        private constant integer ID_ABILITY = 'A19K'
        
        private constant integer DAMAGE_FIRST_LEVEL = 52
        private constant integer DAMAGE_LEVEL_BONUS = 12
        private constant integer ZONE_SIZE = 250
        private constant integer AREA = 175
        private constant integer LIFE_TIME = 10
        
        private constant real TICK = 0.5
        
        private constant string EXPLODE_ANIMATION = "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
        private constant string ZONE_ANIMATION = "war3mapImported\\Spell Marker Gray.mdx"
        
		trigger trg_GunMasterR = null
    endglobals

    function Trig_GunMasterR_Conditions takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY
    endfunction

    private function DealDamage takes effect zone, integer id returns nothing
        local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "codrc" ) )
        local real dmg = LoadReal( udg_hash, id, StringHash( "codrdmg" ) )
        local group g = CreateGroup()
        local unit u
        local real x
        local real y

        set x = Math_GetRandomX(BlzGetLocalSpecialEffectX( zone ), ZONE_SIZE )
        set y = Math_GetRandomY(BlzGetLocalSpecialEffectY( zone ), ZONE_SIZE )
        call DestroyEffect( AddSpecialEffect( EXPLODE_ANIMATION, x, y ) )
        call GroupEnumUnitsInRange( g, x, y, AREA, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, "enemy" ) then
                call UnitTakeDamage( caster, u, dmg, DAMAGE_TYPE_MAGIC )
            endif
            call GroupRemoveUnit(g,u)
        endloop
    
        call GroupClear( g )
        call DestroyGroup( g )
        set g = null
        set u = null
        set caster = null
        set zone = null
    endfunction

    function GunMasterRCast takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local effect zone = LoadEffectHandle( udg_hash, id, StringHash( "codr" ) )
        local integer count = LoadInteger( udg_hash, id, StringHash( "codr" ) ) - 1
        
         if zone == null or count <= 0 then
            call DestroyEffect( zone )
            call FlushChildHashtable( udg_hash, id )
            call DestroyTimer( GetExpiredTimer() )
        else
            call DealDamage(zone, id)
            call SaveInteger( udg_hash, id, StringHash( "codr" ), count )
        endif
        
        set zone = null
    endfunction
    
    private function SpawnZone takes unit caster, real x, real y, integer level returns nothing
        local real damage = DAMAGE_FIRST_LEVEL+(DAMAGE_LEVEL_BONUS*level)
        local integer id
        local effect zone
        local integer count = R2I(LIFE_TIME/TICK)
        
        set zone = AddSpecialEffect(ZONE_ANIMATION, x, y)
        call BlzSetSpecialEffectScale( zone, ZONE_SIZE/100 )
        
        set id = InvokeTimerWithEffect(zone, "codr", TICK, true, function GunMasterRCast )
        call SaveReal( udg_hash, id, StringHash( "codrdmg" ), damage )
        call SaveInteger( udg_hash, id, StringHash( "codr" ), count )
        call SaveUnitHandle( udg_hash, id, StringHash( "codrc" ), caster )
        
        set caster = null
        set zone = null
    endfunction

    function Trig_GunMasterR_Actions takes nothing returns nothing
        local unit caster
        local integer lvl
        local real x
        local real y
   		local real dist 
   		local real angle 
        
        if CastLogic() then
            set caster = udg_Caster
        	set x = GetSpellTargetX()
        	set y = GetSpellTargetY()
            set lvl = udg_Level
        elseif RandomLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
        	set dist = GetRandomReal( 0, 730 )
        	set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        	set x = GetUnitX( caster ) + dist * Cos( angle )
        	set y = GetUnitY( caster ) + dist * Sin( angle )
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        	set x = GetSpellTargetX()
        	set y = GetSpellTargetY()
        endif
        
        call SpawnZone(caster, x, y, lvl)
        set caster = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set trg_GunMasterR = CreateTrigger(  )
        call TriggerRegisterAnyUnitEventBJ( trg_GunMasterR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trg_GunMasterR, Condition( function Trig_GunMasterR_Conditions ) )
        call TriggerAddAction( trg_GunMasterR, function Trig_GunMasterR_Actions )
    endfunction

endscope