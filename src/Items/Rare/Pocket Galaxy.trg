{
  "Id": 50332658,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    integer array LastForgeItems[5][4]//playerIndex/item\r\nendglobals\r\n\r\nfunction Trig_Pocket_Galaxy_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0GK'\r\nendfunction\r\n\r\nfunction Trig_Pocket_Galaxy_Actions takes nothing returns nothing\r\n    local integer playerIndex = GetUnitUserData(GetManipulatingUnit())\r\n\tcall forge( GetManipulatingUnit(), GetManipulatedItem(), LastForgeItems[playerIndex][1], LastForgeItems[playerIndex][2], LastForgeItems[playerIndex][3], true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Pocket_Galaxy takes nothing returns nothing\r\n    set gg_trg_Pocket_Galaxy = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Pocket_Galaxy, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Pocket_Galaxy, Condition( function Trig_Pocket_Galaxy_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Pocket_Galaxy, function Trig_Pocket_Galaxy_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}