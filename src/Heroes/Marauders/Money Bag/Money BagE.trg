{
  "Id": 50333156,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Money_BagE_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A17W'\r\nendfunction\r\n\r\nfunction Trig_Money_BagE_Actions takes nothing returns nothing\r\n    call UnitAddAbility( GetLearningUnit(), 'A17X')\r\n    call SetUnitAbilityLevel(GetLearningUnit(), 'A17X', GetUnitAbilityLevel(GetLearningUnit(), 'A17W') )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Money_BagE takes nothing returns nothing\r\n    set gg_trg_Money_BagE = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Money_BagE, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_Money_BagE, Condition( function Trig_Money_BagE_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Money_BagE, function Trig_Money_BagE_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}