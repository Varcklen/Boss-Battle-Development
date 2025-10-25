scope OutcastPassive initializer init

globals
	private constant integer WITHDRAWAL_ABIL = 'AODE'
	private constant integer WITHDRAWAL_BUFF = 'BODE'
	private constant integer ALL_GAIN = 3
	private constant integer SAFE_TIME = 5
	private constant integer DMG_TICK = 2
	//Abilities\Spells\Other\Stampede\StampedeMissileDeath.mdl
    private constant string ANIMATION = "Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl"
    
	private constant real DMG_BUFF_BASE = 0.25
	private constant real DMG_BUFF_SCALE = 0.15

	private constant integer ID_OUTCAST_E = 'A082'
	
	private integer array ID_OUTCAST_ABILITIES[OutcastFrame_BALL_AMOUNT]
	private timer timerWd
endglobals

private function reset takes unit u returns nothing
	local integer i

	call OutcastFrame_SetBallVisibility(u, OutcastFrame_BALL_RED, false)
	call OutcastFrame_SetBallVisibility(u, OutcastFrame_BALL_GREEN, false)
	call OutcastFrame_SetBallVisibility(u, OutcastFrame_BALL_BLUE, false)
	
	set i = 0
	loop
		exitwhen i >= OutcastFrame_BALL_AMOUNT
		set udg_outcast[i+1] = 3
		if GetUnitAbilityLevel( u, ID_OUTCAST_ABILITIES[i] ) > 0 then
    		call OutcastFrame_SetBallVisibility(u, i, true)
		endif
		set i = i + 1
	endloop
endfunction

//---

private function learnConditions takes nothing returns boolean
    return GetLearnedSkill() == ID_OUTCAST_E
endfunction

private function learnActions takes nothing returns nothing
    //local integer id = GetHandleId( GetLearningUnit() )
	local unit u = GetLearningUnit()
	//local integer t = 2 + GetUnitAbilityLevel( u, GetLearnedSkill() )
	call OutcastFrame_SetVisibility(u, true)
	call reset( u )
	set u = null
endfunction

//---

private function ModalWithdrawal takes nothing returns nothing
	local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit hero = LoadUnitHandle( udg_hash, id, StringHash( "withdraw_od" ) )
    local integer heroId = GetHandleId( hero )
    local boolean safeMode = LoadBoolean(udg_hash, id, StringHash("withdraw_od") )
        //---------------
    local integer counter = LoadInteger( udg_hash, id, StringHash( "withdraw_od" ) )
    //local boolean inWithdrawal = LoadBoolean(udg_hash, heroId, StringHash("withdraw_od") )
    local integer level = GetUnitAbilityLevel(hero, ID_OUTCAST_E)
    local real bonus
    
    if safeMode then
        call FlushChildHashtable( udg_hash, id )
        call DestroyTimer( GetExpiredTimer() )
        set id = InvokeTimerWithUnit( hero, "withdraw_od", DMG_TICK, true, function ModalWithdrawal)
        call SaveInteger( udg_hash, id, StringHash( "withdraw_od" ), 1 )			// reset drain count
        //call SaveBoolean( udg_hash, heroId, StringHash("withdraw_od"), true )		// flag Withdrawal
        call SaveBoolean( udg_hash, id, StringHash("withdraw_od"), false )			// Swap safeMode
        set bonus = DMG_BUFF_BASE + DMG_BUFF_SCALE * level
        call SaveReal( udg_hash, heroId, StringHash( "withdraw_od_b" ), bonus )
    	call UnitAddAbility( hero, WITHDRAWAL_ABIL )
    else
    	if IsUnitAlive(hero) and IsUnitHasAbility( hero, WITHDRAWAL_BUFF) /*and inWithdrawal*/ then
            if IsUnitLoaded( hero ) == false and IsUnitHidden(hero) == false and combat( hero, false, 0 ) then
                call AddHealthPercent(hero, -counter)
                call PlaySpecialEffect(ANIMATION, hero)
                set counter = counter * 2
        		call SaveInteger( udg_hash, id, StringHash( "withdraw_od" ), counter )
            endif
        else
            call FlushChildHashtable( udg_hash, id ) 
            call DestroyTimer( GetExpiredTimer() )
            if IsUnitAlive( hero ) then
            	set id = InvokeTimerWithUnit( hero, "withdraw_od", SAFE_TIME, false, function ModalWithdrawal)
        		call SaveBoolean( udg_hash, id, StringHash("withdraw_od"), true )	// Swap safeMode
    			call UnitRemoveAbility( hero, WITHDRAWAL_ABIL )
   	 			call UnitRemoveAbility( hero, WITHDRAWAL_BUFF )
            endif
        endif
    endif
    set hero = null
endfunction
//---

private function startConditions takes nothing returns boolean
    return GetUnitAbilityLevel( udg_FightStart_Unit, ID_OUTCAST_E) > 0 and not(udg_fightmod[3])
endfunction

private function startActions takes nothing returns nothing
	local integer id
	local unit u = udg_FightStart_Unit
    local integer heroId = GetHandleId( u )
	call reset( u )
	
	set id = InvokeTimerWithUnit( u, "withdraw_od", SAFE_TIME, false, function ModalWithdrawal)
    call SaveBoolean(udg_hash, id, StringHash("withdraw_od"), true )
    //call SaveBoolean(udg_hash, heroId, StringHash("withdraw_od"), false )		// unflag Withdrawal
    call UnitRemoveAbility( u, WITHDRAWAL_ABIL )
    call UnitRemoveAbility( u, WITHDRAWAL_BUFF )
	set u = null
endfunction

//---

    //When hero deals damage and has buff
    private function OnDamageChange_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( udg_DamageEventSource, WITHDRAWAL_BUFF) > 0 //and udg_IsDamageSpell == false
    endfunction
    
    private function OnDamageChange takes nothing returns nothing
        local real bonusDamage = LoadReal(udg_hash, GetHandleId(udg_DamageEventSource), StringHash("withdraw_od_b") ) * (GetHeroAgi( udg_DamageEventSource, false) + GetHeroInt( udg_DamageEventSource, false))
        
        /*if udg_IsDamageSpell then
            set bonusDamage = bonusDamage * 0.5
        endif*/
        set udg_DamageEventAmount = udg_DamageEventAmount + bonusDamage
        
    endfunction

//---
private function OnAbilityNulling_Condition takes nothing returns boolean
    return GetUnitAbilityLevel( udg_Event_NullingAbility_Unit, ID_OUTCAST_E) > 0
endfunction

private function OnAbilityNulling takes nothing returns nothing
	call OutcastFrame_SetVisibility(udg_Event_NullingAbility_Unit, false)
endfunction

//---

private function endConditions takes nothing returns boolean
    return GetUnitAbilityLevel( udg_FightEnd_Unit, ID_OUTCAST_E) > 0 and not(udg_fightmod[3])
endfunction

private function endActions takes nothing returns nothing
	local unit caster = udg_FightEnd_Unit
    local integer lvl = GetUnitAbilityLevel( caster, ID_OUTCAST_E)
    local integer bonus = ALL_GAIN + lvl - 1
    local integer i = 1
    local integer gained = 0
    loop
    	exitwhen i > OutcastFrame_BALL_AMOUNT
    	if udg_outcast[i] >= 0 and GetUnitAbilityLevel( caster, ID_OUTCAST_ABILITIES[i-1] ) > 0 then
    		set udg_outcast[i] = ALL_GAIN
		    set gained = gained + ALL_GAIN
		else
			set udg_outcast[i] = 0
		endif
		set i = i + 1
	endloop
	if gained > 0 then
		if gained == ALL_GAIN * 3 then
			set udg_outcast[1] = bonus
			set udg_outcast[2] = bonus
			call textst( "Power Tamed! +" + I2S(bonus * 2 + ALL_GAIN), caster, 64, GetRandomInt( 45, 135 ), 10, 4 )
		else
			call textst( "Power Contained! +" + I2S(gained), caster, 64, GetRandomInt( 45, 135 ), 10, 4 )
		endif
		call statst( caster, udg_outcast[1], udg_outcast[2], udg_outcast[3], 0, true )
		call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", caster, "origin" ) )
	endif
	
	set caster = null
endfunction

//---------------

private function resetWithdrawal takes nothing returns nothing
	local integer idx = GetHandleId( GetExpiredTimer( ) )
	local unit hero = LoadUnitHandle(udg_hash, idx, StringHash("withdraw_od_reset"))
    local integer heroId = GetHandleId( hero )
    local integer id
    
    set id = InvokeTimerWithUnit( hero, "withdraw_od", SAFE_TIME, false, function ModalWithdrawal)
    call SaveBoolean(udg_hash, id, StringHash("withdraw_od"), true )
    call UnitRemoveAbility( hero, WITHDRAWAL_ABIL )
    call UnitRemoveAbility( hero, WITHDRAWAL_BUFF )
    set hero = null
endfunction

//---------------

private function castConditions takes nothing returns boolean
	local integer id = GetSpellAbilityId()
    return (id == ID_OUTCAST_ABILITIES[0] or id == ID_OUTCAST_ABILITIES[1] or id == ID_OUTCAST_ABILITIES[2])// and combat( GetSpellAbilityUnit(), false, 0 )
endfunction

private function castActions takes nothing returns nothing
	local unit hero = GetSpellAbilityUnit()
    //local integer heroId = GetHandleId( hero )
    local integer id
    
	set id = InvokeTimerWithUnit( hero, "withdraw_od_reset", 0.15, false, function resetWithdrawal)
    //call SaveBoolean(udg_hash, heroId, StringHash("withdraw_od"), false )
    call SaveUnitHandle( udg_hash, id, StringHash("withdraw_od_reset"), hero )
    
    set hero = null
endfunction

//---------------

private function revConditions takes nothing returns boolean
	return GetUnitAbilityLevel( GetTriggerUnit(), ID_OUTCAST_E) > 0
endfunction

private function revActions takes nothing returns nothing
	local unit hero = GetTriggerUnit()
    //local integer heroId = GetHandleId( hero )
    local integer id
    
	set id = InvokeTimerWithUnit( hero, "withdraw_od_reset", 0.04, false, function resetWithdrawal)
    //call SaveBoolean(udg_hash, heroId, StringHash("withdraw_od"), false )
    call SaveUnitHandle( udg_hash, id, StringHash("withdraw_od_reset"), hero )
    
    set hero = null
endfunction

//---------------

private function Disable_Check takes nothing returns boolean
	return GetUnitAbilityLevel( Event_HeroRepick_Hero, ID_OUTCAST_E) > 0
endfunction

private function Disable takes nothing returns nothing
	local unit hero = Event_HeroRepick_Hero
	local integer id = GetHandleId( hero )
	local timer timerUsed = LoadTimerHandle( udg_hash, id, StringHash("withdraw_od") )
	local integer idx = GetHandleId( timerUsed ) 
	call FlushChildHashtable( udg_hash, id )
	call FlushChildHashtable( udg_hash, idx )
    call DestroyTimer( timerUsed )
		
	set timerUsed = null
	set hero = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    local trigger trigLearn = CreateTrigger(  )
    local trigger trigStart = CreateTrigger(  )
    local trigger trigEnd = CreateTrigger(  )
    local trigger trigRev = CreateTrigger(  )
    local trigger resetWdrwl = null
	set ID_OUTCAST_ABILITIES[0] = 'A07J'
	set ID_OUTCAST_ABILITIES[1] = 'A07Y'
	set ID_OUTCAST_ABILITIES[2] = 'A07Z'
	
    //call RegisterDuplicatableItemType(ITEM, EVENT_PLAYER_UNIT_SPELL_EFFECT, function actions, function conditions)
    call TriggerRegisterAnyUnitEventBJ( trigRev, EVENT_PLAYER_HERO_REVIVE_FINISH )
    call TriggerAddCondition( trigRev, Condition( function revConditions ) )
    call TriggerAddAction( trigRev, function revActions )
	
    set resetWdrwl = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function castActions, function castConditions )
    call CreateEventTrigger( "Event_HeroRepick_Real", function Disable, function Disable_Check )
    	
    call TriggerRegisterAnyUnitEventBJ( trigLearn, EVENT_PLAYER_HERO_SKILL )
    call TriggerAddCondition( trigLearn, Condition( function learnConditions ) )
    call TriggerAddAction( trigLearn, function learnActions )
    
    call TriggerRegisterVariableEvent( trigStart, "udg_FightStart_Real", EQUAL, 1.00 )
    call TriggerAddCondition( trigStart, Condition( function startConditions ) )
    call TriggerAddAction( trigStart, function startActions )
    
    call TriggerRegisterVariableEvent( trigEnd, "udg_FightEnd_Real", EQUAL, 1.00 )
    call TriggerAddCondition( trigEnd, Condition( function endConditions ) )
    call TriggerAddAction( trigEnd, function endActions )
    
    call CreateEventTrigger( "udg_Event_NullingAbility_Real", function OnAbilityNulling, function OnAbilityNulling_Condition )
    call CreateEventTrigger( "Event_OnDamageChange_Real", function OnDamageChange, function OnDamageChange_Conditions )
    
    set trigLearn = null
    set trigStart = null
    set trigEnd = null
    set trigRev = null
endfunction

endscope
