scope LycanthropeR initializer init

    globals
        private constant integer ID_ABILITY = 'A1CN'
        
        private constant integer DURATION_FIRST_LEVEL = 5
        private constant integer DURATION_LEVEL_BONUS = 1
        private constant integer TICK = 1
        private constant integer COST = 50
        private constant integer COST_ALT = 150
        
        private constant real HEAL_COUNT = 0.12
        
        private constant integer EFFECT = 'A1CP'
        private constant integer BUFF = 'B0A7'
        
        private constant real ALT_DAMAGE_COUNT = 0.08
        private constant real ALT_VAMPIRISM = 0.12
        
        private constant integer ALT_EFFECT = 'A1CQ'
        private constant integer ALT_BUFF = 'B0A6'
    
        private constant string ANIMATION = "AncientExplode1.mdx"
        private constant string ALT_ANIMATION = "BarbarianSkinQ.mdx"
        private constant string TICK_ALT_ANIMATION = "BarbarianSkinW.mdx"
        
		trigger LycanthropeR = null
    endglobals

    function Trig_LycanthropeR_Conditions takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY
    endfunction
    
//--------------------------------------------------
    
    private function WolfForm_Tick takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit target = LoadUnitHandle(udg_hash, id, StringHash("lcnrat") )
        local unit caster = LoadUnitHandle(udg_hash, id, StringHash("lcnratc") )
        local integer targetId = GetHandleId(target)
        local real damage = LoadReal(udg_hash, targetId, StringHash("lcnra") )

        if IsUnitAlive(target) and IsUnitHasAbility(target, ALT_EFFECT)  then
            //call UnitTakeDamage(caster,target, damage, DAMAGE_TYPE_MAGIC)
            call GroupAoE( target, 0, 0, damage*ALT_DAMAGE_COUNT, 300, "enemy", TICK_ALT_ANIMATION, null )
            //call healst(caster, null, damage*ALT_VAMPIRISM )
            call healst(target, null, damage*ALT_VAMPIRISM )
        else
            call UnitRemoveAbility(target, ALT_EFFECT)
            call UnitRemoveAbility(target, ALT_BUFF)
            call FlushChildHashtable( udg_hash, id )
        endif
        
        set caster = null
        set target = null
    endfunction
    
    private function WolfForm takes unit caster, unit target, integer level, real duration returns nothing
        local integer id
        local integer targetId = GetHandleId(target)

        call PlaySpecialEffect(ALT_ANIMATION, target)
        
        call bufallst(caster, target, ALT_EFFECT, 0, 0, 0, 0, ALT_EFFECT, "lcnra", duration)
        call RemoveSavedReal( udg_hash, targetId, StringHash( "lcnra" ) )
        
        set id = InvokeTimerWithUnit(target, "lcnrat", TICK, true, function WolfForm_Tick )
        call SaveUnitHandle( udg_hash, id, StringHash("lcnratc"), caster ) 
        
        set target = null
        set caster = null
    endfunction

//--------------------------------------------------

    private function HumanForm_Tick takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit target = LoadUnitHandle(udg_hash, id, StringHash("lcnrt") )
        local unit caster = LoadUnitHandle(udg_hash, id, StringHash("lcnrtc") )
        local integer targetId = GetHandleId(target)
        local real currentHeal = HEAL_COUNT * LoadReal(udg_hash, targetId, StringHash("lcnr") )

        if IsUnitAlive(target) and IsUnitHasAbility(target, EFFECT) then
            call healst(caster, target, currentHeal )
        else
            call UnitRemoveAbility(target, EFFECT)
            call UnitRemoveAbility(target, BUFF)
            call FlushChildHashtable( udg_hash, id )
        endif
        
        set caster = null
        set target = null
    endfunction
    
    private function HumanForm takes unit caster, unit target, integer level, real duration returns nothing
        local integer id
        local integer targetId = GetHandleId(target)

        call PlaySpecialEffect(ANIMATION, target)
        
        call bufallst(caster, target, EFFECT, 0, 0, 0, 0, BUFF, "lcnr", duration)
        call RemoveSavedReal( udg_hash, targetId, StringHash( "lcnr" ) )
        
        set id = InvokeTimerWithUnit(target, "lcnrt", TICK, true, function HumanForm_Tick )
        call SaveUnitHandle( udg_hash, id, StringHash("lcnrtc"), caster ) 
        
        set target = null
        set caster = null
    endfunction

    function Trig_LycanthropeR_Actions takes nothing returns nothing
        local integer lvl
        local unit caster
        local unit target
        local real duration
        
        if CastLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
            set target = udg_Target
            set duration = udg_Time
        elseif RandomLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
            set target = randomtarget( caster, 900, "all", 0, 0, 0 )
            if target == null then
                set caster = null
                return
            endif
            set duration = DURATION_FIRST_LEVEL + ( lvl * DURATION_LEVEL_BONUS)
        else
            set caster = GetSpellAbilityUnit()
            set target = GetSpellTargetUnit()
            set lvl = GetUnitAbilityLevel(caster, ID_ABILITY)
            set duration = DURATION_FIRST_LEVEL + ( lvl * DURATION_LEVEL_BONUS)
        endif
        
        if IsUnitHasAbility(caster, LycanthropeW_WOLF_BUFF) or LycanthropeE_WolfMode then
            call WolfForm(caster, target, lvl, duration)
        	if LycanthropeE_WolfMode == false then
            	call SetUnitState( caster, UNIT_STATE_LIFE, RMaxBJ(0,GetUnitState( caster, UNIT_STATE_LIFE) - COST_ALT ))
        	endif
        else
            call HumanForm(caster, target, lvl, duration)
            call SetUnitState( caster, UNIT_STATE_LIFE, RMaxBJ(0,GetUnitState( caster, UNIT_STATE_LIFE) - COST ))
        endif
        
        
        set caster = null
        set target = null
    endfunction
    
    
    private function AfterDamageEvent_Conditions takes nothing returns boolean
        return IsUnitHasAbility( udg_DamageEventTarget, ALT_EFFECT)
    endfunction
    
    private function AfterDamageEvent takes nothing returns nothing
        local real damageCount = LoadReal(udg_hash, GetHandleId(udg_DamageEventTarget), StringHash("lcnra") )
        
        call SaveReal(udg_hash, GetHandleId(udg_DamageEventTarget), StringHash("lcnra"), damageCount + udg_DamageEventAmount )
    endfunction
    
    
    private function AfterHeal_Conditions takes nothing returns boolean
        return IsUnitHasAbility( Event_AfterHeal_Target, EFFECT)
    endfunction
    
    private function AfterHeal takes nothing returns nothing
        local real healCount = LoadReal(udg_hash, GetHandleId(Event_AfterHeal_Target), StringHash("lcnr") )
        
        call SaveReal(udg_hash, GetHandleId(Event_AfterHeal_Target), StringHash("lcnr"), healCount + Event_AfterHeal_Heal )
    endfunction
    
    
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        local unit hero = Event_DeleteBuff_Unit

        call UnitRemoveAbility( hero, EFFECT )
        call UnitRemoveAbility( hero, BUFF )
        
        set hero = null
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        set LycanthropeR = CreateTrigger(  )
        call TriggerRegisterAnyUnitEventBJ( LycanthropeR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( LycanthropeR, Condition( function Trig_LycanthropeR_Conditions ) )
        call TriggerAddAction( LycanthropeR, function Trig_LycanthropeR_Actions )
        
        call CreateEventTrigger( "udg_AfterDamageEvent", function AfterDamageEvent, function AfterDamageEvent_Conditions )
        call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
        call CreateEventTrigger( "Event_AfterHeal_Real", function AfterHeal, function AfterHeal_Conditions )
    endfunction

endscope

