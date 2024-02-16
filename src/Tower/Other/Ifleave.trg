{
  "Id": 50332268,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Ifleave_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( GetLeavingUnit() ) == 'n031' or GetUnitTypeId( GetLeavingUnit() ) == 'n05B' or GetUnitTypeId( GetLeavingUnit() ) == 'n04S' or GetUnitTypeId( GetLeavingUnit() ) == 'n01K' or GetUnitTypeId(GetLeavingUnit()) == 'n042' or GetUnitTypeId(GetLeavingUnit()) == 'n043' or GetUnitTypeId(GetLeavingUnit()) == 'n044' or GetUnitTypeId(GetLeavingUnit()) == 'n04G'\r\nendfunction\r\n\r\nfunction Trig_Ifleave_Actions takes nothing returns nothing\r\n    call IssuePointOrderLoc( GetLeavingUnit(), \"move\", GetRandomLocInRect(gg_rct_Spawn) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Ifleave takes nothing returns nothing\r\n    set gg_trg_Ifleave = CreateTrigger(  )\r\n    call TriggerRegisterLeaveRectSimple( gg_trg_Ifleave, gg_rct_Spawn )\r\n    call TriggerAddCondition( gg_trg_Ifleave, Condition( function Trig_Ifleave_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Ifleave, function Trig_Ifleave_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}