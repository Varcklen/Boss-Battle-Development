{
  "Id": 50333016,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SludgeR_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A0T8'\r\nendfunction\r\n\r\nfunction Trig_SludgeR_Actions takes nothing returns nothing\r\n    if GetUnitAbilityLevel( GetLearningUnit(), 'A0T8') == 1 then\r\n\t\tcall SetPlayerTechResearchedSwap( 'R004', 1, GetOwningPlayer(GetLearningUnit()) )\r\n    elseif GetUnitAbilityLevel( GetLearningUnit(), 'A0T8') == 2 then\r\n        call UnitAddAbility( GetLearningUnit(), 'A0S6')\r\n\telseif GetUnitAbilityLevel( GetLearningUnit(), 'A0T8') == 3 then\r\n        call UnitAddAbility( GetLearningUnit(), 'A0RW')\r\n\telseif GetUnitAbilityLevel( GetLearningUnit(), 'A0T8') == 4 then\r\n        call UnitAddAbility( GetLearningUnit(), 'A0SD')\r\n\tendif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SludgeR takes nothing returns nothing\r\n    set gg_trg_SludgeR = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_SludgeR, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_SludgeR, Condition( function Trig_SludgeR_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SludgeR, function Trig_SludgeR_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}