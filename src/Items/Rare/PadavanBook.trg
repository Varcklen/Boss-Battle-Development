{
  "Id": 50332645,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PadavanBook_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I04C'\r\nendfunction\r\n\r\nfunction Trig_PadavanBook_Actions takes nothing returns nothing\r\n    call statst( GetManipulatingUnit(), 2, 2, 2, 0, true )\r\n    if GetHeroLevel(GetManipulatingUnit()) <= 5 then\r\n        call SetHeroLevel(GetManipulatingUnit(), GetHeroLevel(GetManipulatingUnit()) + 1, false)\r\n        call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Other\\\\Levelup\\\\LevelupCaster.mdl\", GetManipulatingUnit(), \"origin\" ) )\r\n    else\r\n        call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\HolyBolt\\\\HolyBoltSpecialArt.mdl\", GetManipulatingUnit(), \"origin\" ) )\r\n    endif\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PadavanBook takes nothing returns nothing\r\n    set gg_trg_PadavanBook = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PadavanBook, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_PadavanBook, Condition( function Trig_PadavanBook_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PadavanBook, function Trig_PadavanBook_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}