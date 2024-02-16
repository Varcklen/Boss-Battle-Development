{
  "Id": 50332769,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sandro_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I03F'\r\nendfunction\r\n\r\nfunction Trig_Sandro_Actions takes nothing returns nothing\r\n    call Sandro( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sandro takes nothing returns nothing\r\n    set gg_trg_Sandro = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Sandro, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Sandro, Condition( function Trig_Sandro_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Sandro, function Trig_Sandro_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}