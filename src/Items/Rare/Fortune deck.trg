{
  "Id": 50332602,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Fortune_deck_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0C7'\r\nendfunction\r\n\r\nfunction Trig_Fortune_deck_Actions takes nothing returns nothing\r\n\tcall FortuneDeck( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Fortune_deck takes nothing returns nothing\r\n    set gg_trg_Fortune_deck = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Fortune_deck, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Fortune_deck, Condition( function Trig_Fortune_deck_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Fortune_deck, function Trig_Fortune_deck_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}