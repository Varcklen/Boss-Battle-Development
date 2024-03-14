scope OutcastPassive initializer init

globals
	private constant integer ID_OUTCAST_E = 'A082'
	private integer array ID_OUTCAST_ABILITIES[3]
endglobals

private function reset takes player pl, unit u returns nothing
	local integer i = 1
	if GetLocalPlayer() == pl then
    	call BlzFrameSetVisible( outcastframe, true )
    	call BlzFrameSetVisible( outballframe[1], false )
    	call BlzFrameSetVisible( outballframe[2], false )
    	call BlzFrameSetVisible( outballframe[3], false )
	endif
	
	loop
	exitwhen i > 3
		set udg_outcast[i] = 4
		if (GetLocalPlayer() == pl) and (GetUnitAbilityLevel( u, ID_OUTCAST_ABILITIES[i] ) > 0) then
    		call BlzFrameSetVisible( outballframe[i], true )
		endif
		set i = i + 1
	endloop
	set pl = null
	set u = null
endfunction

//---

private function learnConditions takes nothing returns boolean
    return GetLearnedSkill() == ID_OUTCAST_E
endfunction

private function learnActions takes nothing returns nothing
    //local integer id = GetHandleId( GetLearningUnit() )
	local unit u = GetLearningUnit()
	//local integer t = 2 + GetUnitAbilityLevel( u, GetLearnedSkill() )
	call reset( GetOwningPlayer(u), u )
	set u = null
endfunction

//---

private function startConditions takes nothing returns boolean
    return GetUnitAbilityLevel( udg_FightStart_Unit, ID_OUTCAST_E) > 0 and not(udg_fightmod[3])
endfunction

private function startActions takes nothing returns nothing
	call reset( GetOwningPlayer(udg_FightStart_Unit), udg_FightStart_Unit )
endfunction

//---

private function endConditions takes nothing returns boolean
    return GetUnitAbilityLevel( udg_FightEnd_Unit, ID_OUTCAST_E) > 0 and not(udg_fightmod[3])
endfunction

private function endActions takes nothing returns nothing
    local integer lvl = GetUnitAbilityLevel( udg_FightEnd_Unit, ID_OUTCAST_E)
    local integer bonus = lvl + 2
    local integer i = 1
    local integer gained = 0
    loop
    exitwhen i > 3
    	if (udg_outcast[i] >= 0) and (GetUnitAbilityLevel( udg_FightEnd_Unit, ID_OUTCAST_ABILITIES[i] ) > 0) then
    		set udg_outcast[i] = bonus
		    set gained = gained + bonus
		else
			set udg_outcast[i] = 0
		endif
		set i = i + 1
	endloop
	if gained > 0 then
		call statst( udg_FightEnd_Unit, udg_outcast[1], udg_outcast[2], udg_outcast[3], 0, true )
		call textst( "Power Tamed! +" + I2S(gained), udg_FightEnd_Unit, 64, GetRandomInt( 45, 135 ), 10, 4 )
		call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DemonBoltImpact\\DemonBoltImpact.mdl", udg_FightEnd_Unit, "origin" ) )
	endif
endfunction

//===========================================================================
private function init takes nothing returns nothing
    local trigger trigLearn = CreateTrigger(  )
    local trigger trigStart = CreateTrigger(  )
    local trigger trigEnd = CreateTrigger(  )
	set ID_OUTCAST_ABILITIES[1] = 'A07J'
	set ID_OUTCAST_ABILITIES[2] = 'A07Y'
	set ID_OUTCAST_ABILITIES[3] = 'A07Z'
    call TriggerRegisterAnyUnitEventBJ( trigLearn, EVENT_PLAYER_HERO_SKILL )
    call TriggerAddCondition( trigLearn, Condition( function learnConditions ) )
    call TriggerAddAction( trigLearn, function learnActions )
    
    call TriggerRegisterVariableEvent( trigStart, "udg_FightStart_Real", EQUAL, 1.00 )
    call TriggerAddCondition( trigStart, Condition( function startConditions ) )
    call TriggerAddAction( trigStart, function startActions )
    
    call TriggerRegisterVariableEvent( trigEnd, "udg_FightEnd_Real", EQUAL, 1.00 )
    call TriggerAddCondition( trigEnd, Condition( function endConditions ) )
    call TriggerAddAction( trigEnd, function endActions )
    
    set trigLearn = null
    set trigStart = null
    set trigEnd = null
endfunction

endscope
