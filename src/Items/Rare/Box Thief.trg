{
  "Id": 50332569,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Box_Thief_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0GM'\r\nendfunction\r\n\r\nfunction Trig_Box_Thief_Actions takes nothing returns nothing\r\n\tcall forge( GetManipulatingUnit(), GetManipulatedItem(), THIEF_PIECE_01, THIEF_PIECE_02, THIEF_PIECE_03, true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Box_Thief takes nothing returns nothing\r\n    set gg_trg_Box_Thief = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Box_Thief, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Box_Thief, Condition( function Trig_Box_Thief_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Box_Thief, function Trig_Box_Thief_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}