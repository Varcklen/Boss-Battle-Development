scope CorruptedEntQ initializer init

    globals
        private constant integer ID_ABILITY = 'A0OE'
    
        private constant integer AREA = 200
        private constant integer HEAL_FIRST_LEVEL = 50
        private constant integer HEAL_LEVEL_BONUS = 25
        private constant integer DAMAGE_FIRST_LEVEL = 0
        private constant integer DAMAGE_LEVEL_BONUS = 25
        public constant integer CHARGE_LIMIT = 3
        private constant integer DELAY = 2
        
        private constant string BLOOM_EFFECT = "Objects\\Spawnmodels\\Undead\\CryptFiendEggsack\\CryptFiendEggsack.mdl"
        private constant string EXPLODE_EFFECT = "war3mapImported\\ArcaneExplosion.mdx"
        
        private constant real ALT_DELAY = 0.1
        
        real Event_Corrupted_End_Q_Real
        unit Event_Corrupted_End_Q_Unit
        unit Event_Corrupted_End_Q_Caster
        
		trigger trg_Corrupted_EntQ = null
    endglobals

    function Trig_Corrupted_EntQ_Conditions takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY
    endfunction
    
    private function Explode takes unit caster, real x, real y, real damage, real heal returns nothing
        local group g = CreateGroup()
        local unit u
    
        call GroupEnumUnitsInRange( g, x, y, AREA, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, TARGET_ENEMY ) and damage > 0 then
                call UnitTakeDamage( caster, u, damage, DAMAGE_TYPE_MAGIC )
            elseif unitst( u, caster, TARGET_ALLY )  then
                call healst(caster, u , heal)
            endif
            
            set Event_Corrupted_End_Q_Caster = caster
            set Event_Corrupted_End_Q_Unit = u
            
            set Event_Corrupted_End_Q_Real = 0.00
            set Event_Corrupted_End_Q_Real = 1.00
            set Event_Corrupted_End_Q_Real = 0.00
            call GroupRemoveUnit(g,u)
        endloop
        
        call GroupClear( g )
        call DestroyGroup( g )
        set u = null
        set g = null
        set caster = null
    endfunction

    private function Corrupted_EntQExplode takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local effect bloom = LoadEffectHandle( udg_hash, id, StringHash( "entq" ) )
        local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "entqc" ) )
        local real damage = LoadReal( udg_hash, id, StringHash( "entqdmg" ) )
        local real heal = LoadReal( udg_hash, id, StringHash( "entqhl" ) )
        local real x = BlzGetLocalSpecialEffectX( bloom )
        local real y = BlzGetLocalSpecialEffectY( bloom )

        call DestroyEffect( AddSpecialEffect( EXPLODE_EFFECT, x, y ) )
        call Explode(caster, x, y, damage, heal)
        call DestroyEffect(bloom)
        call FlushChildHashtable( udg_hash, id )
        
        set bloom = null
        set caster = null
    endfunction

    private function Corrupted_EntQ_Alternative takes unit caster, real x, real y, real heal returns nothing
        local effect bloom
        local integer id
    
        set bloom = AddSpecialEffect(BLOOM_EFFECT, x, y)
        set id = InvokeTimerWithEffect( bloom, "entq", ALT_DELAY, false, function Corrupted_EntQExplode )
        call SaveUnitHandle(udg_hash, id, StringHash("entqc"), caster )
        call SaveReal(udg_hash, id, StringHash("entqdmg"), 0 )
        call SaveReal(udg_hash, id, StringHash("entqhl"), heal )
        
        set caster = null
        set bloom = null
    endfunction

    private function Corrupted_EntQ takes unit caster, real x, real y, real damage, real heal returns nothing
        local effect bloom
        local integer id
    
        set bloom = AddSpecialEffect(BLOOM_EFFECT, x, y)
        set id = InvokeTimerWithEffect( bloom, "entq", DELAY, false, function Corrupted_EntQExplode )
        call SaveUnitHandle(udg_hash, id, StringHash("entqc"), caster )
        call SaveReal(udg_hash, id, StringHash("entqdmg"), damage )
        call SaveReal(udg_hash, id, StringHash("entqhl"), heal )
        
        set caster = null
        set bloom = null
    endfunction

    function Trig_Corrupted_EntQ_Actions takes nothing returns nothing
        local unit caster
        local integer lvl
        local real x
        local real y
    	local real dist 
    	local real angle 
        local integer damage
        local integer heal
        
        if CastLogic() then
            set caster = udg_Target
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
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        	set x = GetSpellTargetX()
        	set y = GetSpellTargetY()
        endif
        
        set damage = DAMAGE_FIRST_LEVEL + (lvl * DAMAGE_LEVEL_BONUS)
        set heal = HEAL_FIRST_LEVEL + (lvl * HEAL_LEVEL_BONUS)
        
        if Aspects_IsHeroAspectActive(caster, ASPECT_01 ) then
            call Corrupted_EntQ_Alternative( caster, x, y, heal )
        else
            call Corrupted_EntQ( caster, x, y, damage, heal )
        endif

        set caster = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set trg_Corrupted_EntQ = CreateTrigger(  )
        call TriggerRegisterAnyUnitEventBJ( trg_Corrupted_EntQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trg_Corrupted_EntQ, Condition( function Trig_Corrupted_EntQ_Conditions ) )
        call TriggerAddAction( trg_Corrupted_EntQ, function Trig_Corrupted_EntQ_Actions )
    endfunction

endscope

