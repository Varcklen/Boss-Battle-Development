{
  "Id": 50332841,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Heros_Soul_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0G2' and udg_Ability_Spec[GetPlayerId(GetOwningPlayer(GetManipulatingUnit())) + 1] == 0\r\nendfunction\r\n\r\nfunction Trig_Heros_Soul_Actions takes nothing returns nothing\r\n    call forgespell(GetManipulatingUnit(), GetManipulatedItem())\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Heros_Soul takes nothing returns nothing\r\n    set gg_trg_Heros_Soul = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Heros_Soul, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Heros_Soul, Condition( function Trig_Heros_Soul_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Heros_Soul, function Trig_Heros_Soul_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}