scope OutcastPassive initializer init

globals
	private constant integer ID_OUTCAST_E = 'A082'
	private integer array ID_OUTCAST_ABILITIES[OutcastFrame_BALL_AMOUNT]
endglobals

private function reset takes unit u returns nothing
	local integer i
	
	//call OutcastFrame_SetVisibility(u, true)
	call OutcastFrame_SetBallVisibility(u, OutcastFrame_BALL_RED, false)
	call OutcastFrame_SetBallVisibility(u, OutcastFrame_BALL_GREEN, false)
	call OutcastFrame_SetBallVisibility(u, OutcastFrame_BALL_BLUE, false)
	/*if GetLocalPlayer() == pl then
    	call BlzFrameSetVisible( outcastframe, true )
    	call BlzFrameSetVisible( outballframe[1], false )
    	call BlzFrameSetVisible( outballframe[2], false )
    	call BlzFrameSetVisible( outballframe[3], false )
	endif*/
	
	set i = 0
	loop
		exitwhen i >= OutcastFrame_BALL_AMOUNT
		set udg_outcast[i+1] = 4
		if GetUnitAbilityLevel( u, ID_OUTCAST_ABILITIES[i] ) > 0 then
    		//call BlzFrameSetVisible( outballframe[i], true )
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

private function startConditions takes nothing returns boolean
    return GetUnitAbilityLevel( udg_FightStart_Unit, ID_OUTCAST_E) > 0 and not(udg_fightmod[3])
endfunction

private function startActions takes nothing returns nothing
	call reset( udg_FightStart_Unit )
endfunction

//---


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
    local integer bonus = lvl + 2
    local integer i = 1
    local integer gained = 0
    loop
    	exitwhen i > OutcastFrame_BALL_AMOUNT
    	/*call BJDebugMsg("==============")
    	call BJDebugMsg("i: " + I2S(i))
    	call BJDebugMsg("udg_outcast[i]: " + I2S(udg_outcast[i]))*/
    	if udg_outcast[i] >= 0 and GetUnitAbilityLevel( caster, ID_OUTCAST_ABILITIES[i-1] ) > 0 then
    		set udg_outcast[i] = bonus
		    set gained = gained + bonus
		else
			set udg_outcast[i] = 0
		endif
		set i = i + 1
	endloop
	/*call BJDebugMsg("-------------------")
	call BJDebugMsg("RESULT: ")
	call BJDebugMsg("gained: " + I2S(gained))
	call BJDebugMsg("udg_outcast[1]: " + I2S(udg_outcast[1]))
	call BJDebugMsg("udg_outcast[2]: " + I2S(udg_outcast[2]))
	call BJDebugMsg("udg_outcast[3]: " + I2S(udg_outcast[3]))*/
	if gained > 0 then
		call statst( caster, udg_outcast[1], udg_outcast[2], udg_outcast[3], 0, true )
		call textst( "Power Tamed! +" + I2S(gained), caster, 64, GetRandomInt( 45, 135 ), 10, 4 )
		call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", caster, "origin" ) )
	endif
	
	set caster = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    local trigger trigLearn = CreateTrigger(  )
    local trigger trigStart = CreateTrigger(  )
    local trigger trigEnd = CreateTrigger(  )
	set ID_OUTCAST_ABILITIES[0] = 'A07J'
	set ID_OUTCAST_ABILITIES[1] = 'A07Y'
	set ID_OUTCAST_ABILITIES[2] = 'A07Z'
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
    
    set trigLearn = null
    set trigStart = null
    set trigEnd = null
endfunction

endscope
