{
  "Id": 50333020,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PredatorE_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A15Q'\r\nendfunction\r\n\r\nfunction Trig_PredatorE_Actions takes nothing returns nothing\r\n    local unit hero = GetLearningUnit()\r\n    \r\n    if GetUnitAbilityLevel(hero, GetLearnedSkill()) == 1 then\r\n        call UnitAddAbility(hero, 'A0G6')\r\n    endif\r\n\tcall SetUnitAbilityLevel( hero, 'A0G6', GetUnitAbilityLevel(hero, GetLearnedSkill()) )\r\n\r\n    set hero = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PredatorE takes nothing returns nothing\r\n    set gg_trg_PredatorE = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PredatorE, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_PredatorE, Condition( function Trig_PredatorE_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PredatorE, function Trig_PredatorE_Actions )\r\nendfunction\r\n\r\nscope PredatorE initializer Triggs\r\n    private function Use takes nothing returns nothing\r\n        local unit hero = udg_Event_NullingAbility_Unit\r\n        local integer lvl = GetUnitAbilityLevel( hero, 'A15Q')\r\n        \r\n        call UnitRemoveAbility(hero, 'A0G6')\r\n        \r\n        set hero = null\r\n    endfunction\r\n\r\n    private function Triggs takes nothing returns nothing\r\n        local trigger trig = CreateTrigger()\r\n        call TriggerRegisterVariableEvent( trig, \"udg_Event_NullingAbility_Real\", EQUAL, 1.00 )\r\n        call TriggerAddAction( trig, function Use)\r\n        \r\n\r\n        set trig = null\r\n    endfunction\r\nendscope\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}