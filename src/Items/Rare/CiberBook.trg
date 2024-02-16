{
  "Id": 50332574,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_CiberBook_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I08N'\r\nendfunction\r\n\r\nfunction Trig_CiberBook_Actions takes nothing returns nothing\r\n    local unit u = udg_hero[GetPlayerId(GetOwningPlayer( GetManipulatingUnit() ) ) + 1]\r\n\r\n    call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )\r\n    call spectimeunit( u, \"Abilities\\\\Spells\\\\Other\\\\Silence\\\\SilenceAreaBirth.mdl\", \"origin\", 0.6 )\r\n    if SetCount_GetPieces(u, SET_MECH) > 0 then\r\n        call SetHeroLevel( GetManipulatingUnit(), GetHeroLevel(GetManipulatingUnit()) + SetCount_GetPieces(u, SET_MECH), true )\r\n    endif\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    \r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_CiberBook takes nothing returns nothing\r\n    set gg_trg_CiberBook = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_CiberBook, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_CiberBook, Condition( function Trig_CiberBook_Conditions ) )\r\n    call TriggerAddAction( gg_trg_CiberBook, function Trig_CiberBook_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}