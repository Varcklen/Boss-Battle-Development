{
  "Id": 50332989,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_WandererEHP_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A0LD'\r\nendfunction\r\n\r\nfunction Trig_WandererEHP_Actions takes nothing returns nothing\r\n\tif GetUnitAbilityLevel( GetLearningUnit(), 'A0LD') == 1 then\r\n        call BlzSetUnitMaxHP( GetLearningUnit(), BlzGetUnitMaxHP(GetLearningUnit()) + 50 )\r\n\tendif\r\n    call BlzSetUnitMaxHP( GetLearningUnit(), BlzGetUnitMaxHP(GetLearningUnit()) + 30 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_WandererEHP takes nothing returns nothing\r\n    set gg_trg_WandererEHP = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_WandererEHP, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_WandererEHP, Condition( function Trig_WandererEHP_Conditions ) )\r\n    call TriggerAddAction( gg_trg_WandererEHP, function Trig_WandererEHP_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}