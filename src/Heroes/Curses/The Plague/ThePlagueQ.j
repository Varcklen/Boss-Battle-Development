scope ThePlagueQ initializer init

    globals
        private constant integer ID_ABILITY = 'A1CS'
        
        private constant integer LIFE_TIME = 18
        private constant integer AREA = 300
        private constant real TICK = 0.04
        private constant integer TICK_DAMAGE = 1
        private constant integer FLIGHT_LIMIT = 200
        private constant integer DISTANCE_TO_ACTIVATE = 50
        private constant integer SPEED = 40
        private constant integer WAVE_Z = 60
        
        private constant integer EFFECT = 'A1CT'
        
        public constant integer DAMAGE_FIRST_LEVEL = 2
        public constant integer DAMAGE_LEVEL_BONUS = 8
        
        private constant string ORB_ANIMATION = "Abilities\\Weapons\\GreenDragonMissile\\GreenDragonMissile.mdl"
        private constant string ANIMATION = "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl"
        
		trigger trg_ThePlagueQ = null
    endglobals

    function Trig_The_PlagueQ_Conditions takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY
    endfunction
    
    private function FogDamage takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit fog = LoadUnitHandle( udg_hash, id, StringHash( "tplqf" ) )
        local real damage = LoadReal( udg_hash, id, StringHash( "tplqfd" ) )
        local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "tplqfc" ) )

        if IsUnitDead(fog) then
            call RemoveUnit( fog )
            call FlushChildHashtable( udg_hash, id )
            call DestroyTimer( GetExpiredTimer() )
        else
            call GroupAoE(caster, GetUnitX( fog ), GetUnitY( fog ), damage, AREA, "enemy", null, null )
        endif

        set fog = null
        set caster = null
    endfunction
    
    public function CreatePoisonousFog takes unit caster, real damage, integer level, real x, real y, real duration returns nothing
        local unit fog
        local integer id1
    
        call DestroyEffect( AddSpecialEffect( ANIMATION, x, y ) )
        set fog = CreateUnit( GetOwningPlayer( caster ), 'u000', x, y, 270 )
        call UnitApplyTimedLife( fog , 'BTLF', duration)
        call UnitAddAbility( fog , EFFECT)
        call SetUnitAbilityLevel( fog , EFFECT, level )
        
        set id1 = InvokeTimerWithUnit(fog, "tplqf", TICK_DAMAGE, true, function FogDamage )
        call SaveReal( udg_hash, id1, StringHash( "tplqfd" ), damage )
        call SaveUnitHandle( udg_hash, id1, StringHash( "tplqfc" ), caster )
        
        set fog = null
        set caster = null
    endfunction
    
    private function CreateFog takes integer id, real x, real y returns nothing
        local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "tplqc" ) )
        local real damage = LoadReal( udg_hash, id, StringHash( "tplqd" ) )
        local integer level = LoadInteger( udg_hash, id, StringHash( "tplqlvl" ) )
        
        call CreatePoisonousFog(caster, damage, level, x, y, LIFE_TIME)
        
        set caster = null
    endfunction
    
    private function WaveMove takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local integer counter = LoadInteger( udg_hash, id, StringHash( "tplq" ) ) + 1
        local effect wave = LoadEffectHandle( udg_hash, id, StringHash( "tplq" ) )
        local real angle = LoadReal( udg_hash, id, StringHash( "tplq" ) )
        local real x = LoadReal( udg_hash, id, StringHash( "tplqx" ) )
        local real y = LoadReal( udg_hash, id, StringHash( "tplqy" ) )
        local location newPoint = null
        local location endPoint = Location(x, y)
        local location wavePoint = Location(BlzGetLocalSpecialEffectX( wave ), BlzGetLocalSpecialEffectY( wave ))
        local real distance = DistanceBetweenPoints(wavePoint, endPoint)

        if counter >= FLIGHT_LIMIT or wave == null then
            call DestroyEffect( wave )
            call DestroyTimer( GetExpiredTimer() )
        elseif distance <= DISTANCE_TO_ACTIVATE then
            call CreateFog(id, x, y )
        
            call DestroyEffect( wave )
            call DestroyTimer( GetExpiredTimer() )
        else
            set newPoint = LocationSystem_GetMovedEffect( wave, angle, SPEED )
            call BlzSetSpecialEffectPositionLoc( wave, newPoint )
            call SaveInteger( udg_hash, id, StringHash( "tplq" ), counter )
        endif

        call RemoveLocation(newPoint)
        call RemoveLocation(endPoint)
        call RemoveLocation(wavePoint)
        set endPoint = null
        set wavePoint = null
        set newPoint = null
        set wave = null
    endfunction
    
    private function CreateOrb takes unit caster, real damage, real x, real y, integer level returns nothing
        local integer id
        local effect wave
        local real angle
        local location startPoint = Location( GetUnitX(caster), GetUnitY(caster) )
        local location endPoint = Location(x, y)
    
        set wave = AddSpecialEffectLoc( ORB_ANIMATION, startPoint )
        set angle = AngleBetweenPoints(startPoint, endPoint )
        call BlzSetSpecialEffectYaw( wave, Deg2Rad(angle) )
        call BlzSetSpecialEffectZ( wave, WAVE_Z )
        
        set id = InvokeTimerWithEffect( wave, "tplq", TICK, true, function WaveMove )
        call SaveUnitHandle( udg_hash, id, StringHash( "tplqc" ), caster )
        call SaveInteger( udg_hash, id, StringHash( "tplqlvl" ), level )
        call SaveReal( udg_hash, id, StringHash( "tplq" ), angle )
        call SaveReal( udg_hash, id, StringHash( "tplqd" ), damage )
        call SaveReal( udg_hash, id, StringHash( "tplqx" ), x )
        call SaveReal( udg_hash, id, StringHash( "tplqy" ), y )
    
    	call RemoveLocation(startPoint)
    	call RemoveLocation(endPoint)
    	set startPoint = null
    	set endPoint = null
        set wave = null
        set caster = null
    endfunction

    function Trig_The_PlagueQ_Actions takes nothing returns nothing
        local unit caster
        local integer level
        local real x
        local real y
    	local real dist 
   		local real angle 
        local real damage
        
        if CastLogic() then
            set caster = udg_Target
            set level = udg_Level
        	set x = GetSpellTargetX()
        	set y = GetSpellTargetY()
        elseif RandomLogic() then
            set caster = udg_Caster
            set level = udg_Level
        	set dist = GetRandomReal( 0, 730 )
        	set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        	set x = GetUnitX( caster ) + dist * Cos( angle )
        	set y = GetUnitY( caster ) + dist * Sin( angle )
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
        else
            set caster = GetSpellAbilityUnit()
            set level = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        	set x = GetSpellTargetX()
        	set y = GetSpellTargetY()
        endif
        
        set damage = ( DAMAGE_FIRST_LEVEL + (DAMAGE_LEVEL_BONUS * level) )
        
        call CreateOrb( caster, damage, x, y, level )

        set caster = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set trg_ThePlagueQ = CreateTrigger(  )
        call TriggerRegisterAnyUnitEventBJ( trg_ThePlagueQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trg_ThePlagueQ, Condition( function Trig_The_PlagueQ_Conditions ) )
        call TriggerAddAction( trg_ThePlagueQ, function Trig_The_PlagueQ_Actions )
    endfunction

endscope

