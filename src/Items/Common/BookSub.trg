{
  "Id": 50332398,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_BookSub_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I00H'\r\nendfunction\r\n\r\nfunction Trig_BookSub_Actions takes nothing returns nothing\r\n    call SetHeroLevel( GetManipulatingUnit(), GetHeroLevel(GetManipulatingUnit()) + 1, true)\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_BookSub takes nothing returns nothing\r\n    set gg_trg_BookSub = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_BookSub, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_BookSub, Condition( function Trig_BookSub_Conditions ) )\r\n    call TriggerAddAction( gg_trg_BookSub, function Trig_BookSub_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}