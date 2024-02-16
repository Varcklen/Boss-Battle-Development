{
  "Id": 50332568,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Box_Paragon_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0GL'\r\nendfunction\r\n\r\nfunction Trig_Box_Paragon_Actions takes nothing returns nothing\r\n\tcall forge( GetManipulatingUnit(), GetManipulatedItem(), PARAGON_PIECE_01, PARAGON_PIECE_02, PARAGON_PIECE_03, true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Box_Paragon takes nothing returns nothing\r\n    set gg_trg_Box_Paragon = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Box_Paragon, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Box_Paragon, Condition( function Trig_Box_Paragon_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Box_Paragon, function Trig_Box_Paragon_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}