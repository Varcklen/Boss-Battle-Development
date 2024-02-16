{
  "Id": 50333188,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SkeletonLordP_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A0CK'\r\nendfunction\r\n\r\nfunction Trig_SkeletonLordP_Actions takes nothing returns nothing\r\n    call SaveUnitHandle( udg_hash, 1, StringHash( \"sklp\" ), GetLearningUnit() ) \r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SkeletonLordP takes nothing returns nothing\r\n    set gg_trg_SkeletonLordP = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_SkeletonLordP, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_SkeletonLordP, Condition( function Trig_SkeletonLordP_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SkeletonLordP, function Trig_SkeletonLordP_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}