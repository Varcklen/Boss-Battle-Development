{
  "Id": 50332566,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Box_Mage_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I02T'\r\nendfunction\r\n\r\nfunction Trig_Box_Mage_Actions takes nothing returns nothing\r\n\tcall forge( GetManipulatingUnit(), GetManipulatedItem(), 'I02Q', 'I02J', 'I02D', true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Box_Mage takes nothing returns nothing\r\n    set gg_trg_Box_Mage = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Box_Mage, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Box_Mage, Condition( function Trig_Box_Mage_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Box_Mage, function Trig_Box_Mage_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}