scope SludgeR initializer init
    globals
		trigger trg_SludgeR = null
    endglobals

function Trig_SludgeR_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A0T8'
endfunction

function Trig_SludgeR_Actions takes nothing returns nothing
	local unit u = GetLearningUnit()
    if GetUnitAbilityLevel( u, 'A0T8') == 1 then
		call SetPlayerTechResearchedSwap( 'R004', 1, GetOwningPlayer(u) )
    elseif GetUnitAbilityLevel( u, 'A0T8') == 2 then
        call UnitAddAbility( u, 'A0S6')
	elseif GetUnitAbilityLevel( u, 'A0T8') == 3 then
        call UnitAddAbility( u, 'A0RW')
	elseif GetUnitAbilityLevel( u, 'A0T8') == 4 then
        call UnitAddAbility( u, 'A0SD')
	endif
	set u = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_SludgeR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_SludgeR, EVENT_PLAYER_HERO_SKILL )
    call TriggerAddCondition( trg_SludgeR, Condition( function Trig_SludgeR_Conditions ) )
    call TriggerAddAction( trg_SludgeR, function Trig_SludgeR_Actions )
endfunction

endscope

