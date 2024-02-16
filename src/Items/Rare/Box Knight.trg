{
  "Id": 50332565,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Box_Knight_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I08F'\r\nendfunction\r\n\r\nfunction Trig_Box_Knight_Actions takes nothing returns nothing\r\n\tcall forge( GetManipulatingUnit(), GetManipulatedItem(), 'I000', 'I001', 'I002', true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Box_Knight takes nothing returns nothing\r\n    set gg_trg_Box_Knight = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Box_Knight, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Box_Knight, Condition( function Trig_Box_Knight_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Box_Knight, function Trig_Box_Knight_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}