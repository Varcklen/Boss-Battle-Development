{
  "Id": 50332390,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_AloneBook_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0B4'\r\nendfunction\r\n\r\nfunction Trig_AloneBook_Actions takes nothing returns nothing\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    call SetHeroLevel( GetManipulatingUnit(), GetHeroLevel(GetManipulatingUnit()) + 4, true)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_AloneBook takes nothing returns nothing\r\n    set gg_trg_AloneBook = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_AloneBook, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_AloneBook, Condition( function Trig_AloneBook_Conditions ) )\r\n    call TriggerAddAction( gg_trg_AloneBook, function Trig_AloneBook_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}