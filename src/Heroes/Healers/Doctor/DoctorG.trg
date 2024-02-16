{
  "Id": 50333312,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_DoctorG_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A04L'\r\nendfunction\r\n\r\nfunction Trig_DoctorG_Actions takes nothing returns nothing\r\n\tcall BlzSetUnitMaxHP( GetLearningUnit(), BlzGetUnitMaxHP(GetLearningUnit()) + 75 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DoctorG takes nothing returns nothing\r\n    set gg_trg_DoctorG = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_DoctorG, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_DoctorG, Condition( function Trig_DoctorG_Conditions ) )\r\n    call TriggerAddAction( gg_trg_DoctorG, function Trig_DoctorG_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}