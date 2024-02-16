{
  "Id": 50333005,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MinP_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A083'\r\nendfunction\r\n\r\nfunction Trig_MinP_Actions takes nothing returns nothing\r\n\tif GetUnitAbilityLevel( GetLearningUnit(), 'A083') == 1 then\r\n        call statst( GetLearningUnit(), 2, 1, 1, 0, false )\r\n\tendif\r\n    call statst( GetLearningUnit(), 4, 2, 2, 0, false )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MinP takes nothing returns nothing\r\n    set gg_trg_MinP = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MinP, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_MinP, Condition( function Trig_MinP_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MinP, function Trig_MinP_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}