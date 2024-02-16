{
  "Id": 50332715,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_DarkBook_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I00T'\r\nendfunction\r\n\r\nfunction Trig_DarkBook_Actions takes nothing returns nothing\r\n    call SetHeroLevel( GetManipulatingUnit(), GetHeroLevel(GetManipulatingUnit()) + 3, false )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"war3mapImported\\\\BlackChakraExplosion.mdx\", GetManipulatingUnit(), \"origin\") )\r\n    call statst( GetManipulatingUnit(), -12, -12, -12, 0, true )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DarkBook takes nothing returns nothing\r\n    set gg_trg_DarkBook = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_DarkBook, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_DarkBook, Condition( function Trig_DarkBook_Conditions ) )\r\n    call TriggerAddAction( gg_trg_DarkBook, function Trig_DarkBook_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}