library WrathBarBehaviour initializer init requires WrathBarEffect, StunLib

    globals
        private constant integer DAMAGE_REQUIRES = 45
        private constant integer RESOURCE_TO_ADD = 1
        private constant integer MAX_VALUE = 100
        private constant integer ABILITY_ID = 'A1GR'
    endglobals
    
    private function condition takes nothing returns boolean
        return GetUnitAbilityLevel( udg_DamageEventSource, ABILITY_ID) > 0 and IsUnitAlive(udg_DamageEventSource)
    endfunction
    
    //Stun Penalty
    globals
        private constant real STUN_DURATION = 2
        private constant real CHARGE_LOST_TIME = 2
        private constant real CHARGE_LOST_TICK = 0.04
        private constant integer AMOUNT_OF_TICKS = R2I( CHARGE_LOST_TIME / CHARGE_LOST_TICK )
        private constant integer CHARGE_LOSE_PER_TICK = -MAX_VALUE / AMOUNT_OF_TICKS
        private constant integer KEY_STUN_TIMER = StringHash("wrath_bar_stun_timer")
        private constant string STUN_ANIMATION = "Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl"
    endglobals
    
    private function StunPenaltyEnd takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit hero = LoadUnitHandle( udg_hash, id, StringHash("wrath_bar_stun_timer_caster") )
        local integer counter = LoadInteger(udg_hash, id, StringHash("wrath_bar_stun_timer_counter") ) + 1
        
        call WrathBarEffect_AddValue(hero, CHARGE_LOSE_PER_TICK)
        
        if counter >= AMOUNT_OF_TICKS then
            call WrathBarEffect_SetPenalty(hero, WrathBarEffect_NORMAL_PENALTY)
            call FlushChildHashtable( udg_hash, id )
            call DestroyTimer( GetExpiredTimer() )
        else
            call SaveInteger(udg_hash, id, StringHash("wrath_bar_stun_timer_counter"), counter )
        endif
        
        set hero = null
    endfunction
    
    private function StunPenalty takes unit hero returns nothing
        local integer id
        local timer timerUsed

        //call BJDebugMsg("STUN") //ADD STUN!
        call PlaySpecialEffect(STUN_ANIMATION, hero)
        call UnitStun( hero, hero, STUN_DURATION )
        call WrathBarEffect_SetPenalty(hero, WrathBarEffect_STUN_PENALTY)
        
        set id = GetHandleId( hero )
        if LoadTimerHandle( udg_hash, id, KEY_STUN_TIMER ) == null then
            call SaveTimerHandle( udg_hash, id, KEY_STUN_TIMER, CreateTimer() )
        endif
        set timerUsed = LoadTimerHandle( udg_hash, id, KEY_STUN_TIMER )
        set id = GetHandleId( timerUsed ) 
        call SaveUnitHandle( udg_hash, id, StringHash("wrath_bar_stun_timer_caster"), hero )
        call TimerStart( timerUsed, CHARGE_LOST_TICK, true, function StunPenaltyEnd )
        
        set timerUsed = null
    endfunction
    //
    
    //Slow Condition
    globals
        private constant real CHECK_COOLDOWN = 7
        private constant real SLOW_DURATION = 5
        private constant integer SLOW_EFFECT = 'A1GS'
        private constant integer SLOW_BUFF = 'B0AP'
        private constant integer CHARGE_GAIN_PERCENT_REQUIRE = 20
        private constant integer KEY_SLOW_TIMER = StringHash("wrath_bar_slow_timer")
        private constant integer KEY_SLOW_COOLDOWN = StringHash("wrath_bar_slow_cooldown")
    endglobals
    
    private function SlowCooldownEnd takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit hero = LoadUnitHandle( udg_hash, id, StringHash("wrath_bar_slow_cooldown_caster") )
        
        call WrathBarEffect_SetSlowCheckCooldown(hero, false)
        call WrathBarEffect_SetSlowCheckAmount(hero, 0)
        call SaveTimerHandle( udg_hash, id, KEY_SLOW_COOLDOWN, null )
        call FlushChildHashtable( udg_hash, id )
        
        set hero = null
    endfunction
    
    private function SlowPenaltyEnd takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit hero = LoadUnitHandle( udg_hash, id, StringHash("wrath_bar_slow_timer_caster") )
        
        call UnitRemoveAbility( hero, SLOW_EFFECT )
        call UnitRemoveAbility( hero, SLOW_BUFF )
        if WrathBarEffect_GetPenalty(hero) == WrathBarEffect_SLOW_PENALTY then
            call WrathBarEffect_SetPenalty(hero, WrathBarEffect_NORMAL_PENALTY)
        endif
        call FlushChildHashtable( udg_hash, id )
        
        set hero = null
    endfunction
    
    private function AddSlowPenalty takes unit hero returns nothing
        local integer id
        local timer timerUsed

        //call BJDebugMsg("DEBUFF") 
        call WrathBarEffect_SetSlowCheckCooldown(hero, true)
        call UnitAddAbility( hero, SLOW_EFFECT )
        call WrathBarEffect_SetPenalty(hero, WrathBarEffect_SLOW_PENALTY)
        
        //Buff Duration
        set id = GetHandleId( hero )
        if LoadTimerHandle( udg_hash, id, KEY_SLOW_TIMER ) == null then
            call SaveTimerHandle( udg_hash, id, KEY_SLOW_TIMER, CreateTimer() )
        endif
        set timerUsed = LoadTimerHandle( udg_hash, id, KEY_SLOW_TIMER )
        set id = GetHandleId( timerUsed ) 
        call SaveUnitHandle( udg_hash, id, StringHash("wrath_bar_slow_timer_caster"), hero )
        call TimerStart( timerUsed, SLOW_DURATION, false, function SlowPenaltyEnd )
        
        set timerUsed = null
    endfunction
    
    private function SlowPenaltyCooldown takes unit hero returns nothing
        local integer id
        local timer timerUsed = null
        
        //Cooldown
        set id = GetHandleId( hero )
        if LoadTimerHandle( udg_hash, id, KEY_SLOW_COOLDOWN ) == null then
            call SaveTimerHandle( udg_hash, id, KEY_SLOW_COOLDOWN, CreateTimer() )
        endif
        set timerUsed = LoadTimerHandle( udg_hash, id, KEY_SLOW_COOLDOWN )
        
        if TimerGetRemaining(timerUsed) > 0 then
            set timerUsed = null
            return
        endif
        
        set id = GetHandleId( timerUsed ) 
        call SaveUnitHandle( udg_hash, id, StringHash("wrath_bar_slow_cooldown_caster"), hero )
        call TimerStart( timerUsed, CHECK_COOLDOWN, false, function SlowCooldownEnd )
        
        set timerUsed = null
    endfunction
    
    private function SlowPenalty takes unit hero, real valueToAdd returns nothing
        local real slowCheckAmount = WrathBarEffect_GetSlowCheckAmount(hero)
        
        if WrathBarEffect_GetSlowCheckCooldown(hero) then
            //call BJDebugMsg("WrathBarEffect_GetSlowCheckCooldown(hero)") 
            return
        endif
        if GetUnitAbilityLevel( hero, SLOW_EFFECT) > 0 then
            //call BJDebugMsg("GetUnitAbilityLevel( hero, SLOW_EFFECT) > 0") 
            return
        endif
        
        set slowCheckAmount = slowCheckAmount + valueToAdd
        
        if slowCheckAmount >= CHARGE_GAIN_PERCENT_REQUIRE then
            call AddSlowPenalty(hero)
            call WrathBarEffect_SetSlowCheckAmount(hero, 0)
        else
            call WrathBarEffect_SetSlowCheckAmount(hero, slowCheckAmount)
        endif
        call SlowPenaltyCooldown(hero)
        
        //call BJDebugMsg("Check Slow Penalty")
    endfunction
    //
    
    //Reset
    //ADD EVENT
    private function OnReset takes nothing returns nothing
        local unit hero = udg_FightStart_Unit
        
        if GetUnitAbilityLevel( hero, ABILITY_ID) == 0 then
        	set hero = null
        	return
        endif
        
        call WrathBarEffect_SetSlowCheckAmount(hero, 0)
        call WrathBarEffect_SetSlowCheckCooldown(hero, false)
        call WrathBarEffect_AddValue(hero, -100)
        
        set hero = null
    endfunction

    //OnDamageAction
    private function OnDamageDealt takes nothing returns nothing
        local unit caster = udg_DamageEventSource
        local real damageBuffer = WrathBarEffect_GetDamageBuffer(caster)
        local real damage = udg_DamageEventAmount + damageBuffer
        local integer hits
        local real valueToAdd
        
        set hits = R2I(damage) / DAMAGE_REQUIRES
        set damageBuffer = ModuloReal(damage, DAMAGE_REQUIRES)
        
        call WrathBarEffect_SetDamageBuffer(caster, damageBuffer)
        
        if hits == 0 then
            set caster = null
            return
        endif
        
        set valueToAdd = hits * RESOURCE_TO_ADD * WrathBarEffect_GetPenalty(caster).value
        /*call BJDebugMsg("---------------------")
        call BJDebugMsg("mode: " + I2S(WrathBarEffect_GetPenalty(caster).mode))
        call BJDebugMsg("value: " + R2S(WrathBarEffect_GetPenalty(caster).value))
        call BJDebugMsg("hits: " + I2S(hits))
        call BJDebugMsg("valueToAdd: " + R2S(valueToAdd))*/
        
        if valueToAdd <= 0.1 then
            set caster = null
            return
        endif
        
        call WrathBarEffect_AddValue(caster, valueToAdd)
        if WrathBarEffect_GetValue(caster) >= MAX_VALUE then
            call StunPenalty(caster)
        elseif WrathBarEffect_GetPenalty(caster) == WrathBarEffect_NORMAL_PENALTY then
            call SlowPenalty(caster, valueToAdd)
        endif
        
        set caster = null
    endfunction
    
    //Enable
    private function Enable takes nothing returns nothing
    	if GetUnitAbilityLevel( Event_HeroChoose_Hero, ABILITY_ID) == 0 then
        	return
        endif
        call WrathBarVisual_SetVisibility(Event_HeroChoose_Player, true)
        call WrathBarVisual_SetValue(Event_HeroChoose_Player, 0 )
    endfunction
    
    //Disable
    private function Disable takes nothing returns nothing
    	if GetUnitAbilityLevel( Event_HeroRepick_Hero, ABILITY_ID) == 0 then
        	return
        endif
        call WrathBarEffect_AddValue(Event_HeroRepick_Hero, -100)
        call WrathBarVisual_SetVisibility(Event_HeroRepick_Player, false)
    endfunction

    private function init takes nothing returns nothing
        call CreateEventTrigger( "udg_AfterDamageEvent", function OnDamageDealt, function condition )
        call CreateEventTrigger( "udg_FightStart_Real", function OnReset, null )
        call CreateEventTrigger( "Event_HeroChoose_Real", function Enable, null )
		call CreateEventTrigger( "Event_HeroRepick_Real", function Disable, null )
    endfunction
endlibrary