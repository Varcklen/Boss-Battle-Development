{
  "Id": 50332716,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_GoldCoin_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I00G'\r\nendfunction\r\n\r\nfunction Trig_GoldCoin_Actions takes nothing returns nothing\r\n    call moneyst( GetManipulatingUnit(), 1000 )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_GoldCoin takes nothing returns nothing\r\n    set gg_trg_GoldCoin = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_GoldCoin, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_GoldCoin, Condition( function Trig_GoldCoin_Conditions ) )\r\n    call TriggerAddAction( gg_trg_GoldCoin, function Trig_GoldCoin_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}