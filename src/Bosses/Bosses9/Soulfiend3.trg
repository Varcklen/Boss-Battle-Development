{
  "Id": 50333650,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Soulfiend3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'n04F' and GetUnitLifePercent(udg_DamageEventTarget) <= 50\r\nendfunction\r\n\r\nfunction Trig_Soulfiend3_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call Soulfiend2_CastCurse()\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Soulfiend3 takes nothing returns nothing\r\n    set gg_trg_Soulfiend3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Soulfiend3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Soulfiend3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Soulfiend3, Condition( function Trig_Soulfiend3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Soulfiend3, function Trig_Soulfiend3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}