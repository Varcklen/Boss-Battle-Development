scope MagnataurB initializer init

    globals
		trigger trg_MagnataurB = null
    endglobals
    
function Trig_MagnataurB_Conditions takes nothing returns boolean
    return GetLearnedSkill() == 'A0UF' or GetLearnedSkill() == 'A0VG' or GetLearnedSkill() == 'A0WJ'
endfunction

function Trig_MagnataurB_Actions takes nothing returns nothing
	local unit u = GetLearningUnit()
    if GetLearnedSkill() == 'A0UF' then
        call UnitRemoveAbility( u, 'A0BJ')
        call UnitRemoveAbility( u, 'B03M')
        call UnitAddAbility( u, 'A0BJ')
        call SetUnitAbilityLevel( u, 'A0BC', GetUnitAbilityLevel( u, 'A0UF' ) )
    elseif GetLearnedSkill() == 'A0VG' then
        call UnitRemoveAbility( u, 'A0AV')
        call UnitRemoveAbility( u, 'B03N')
        call UnitAddAbility( u, 'A0AV')
        call SetUnitAbilityLevel( u, 'A0A8', GetUnitAbilityLevel( u, 'A0VG' ) )
    else
        call UnitRemoveAbility( u, 'A0B3')
        call UnitRemoveAbility( u, 'B03P')
        call UnitAddAbility( u, 'A0B3')
        call SetUnitAbilityLevel( u, 'A0N6', GetUnitAbilityLevel( u, 'A0WJ' ) )
    endif
    set u = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_MagnataurB = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_MagnataurB, EVENT_PLAYER_HERO_SKILL )
    call TriggerAddCondition( trg_MagnataurB, Condition( function Trig_MagnataurB_Conditions ) )
    call TriggerAddAction( trg_MagnataurB, function Trig_MagnataurB_Actions )
endfunction
endscope