{
  "Id": 50332739,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Emperor_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I07Z'\r\nendfunction\r\n\r\nfunction Trig_Emperor_Actions takes nothing returns nothing\r\n    if LoadInteger( udg_hash, GetHandleId( GetManipulatingUnit() ), StringHash( \"kill\" ) ) >= 50 then\r\n        call SetHeroLevel(GetManipulatingUnit(), GetHeroLevel(GetManipulatingUnit()) + 5, true)\r\n    else\r\n        call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )\r\n        call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\NightElf\\\\BattleRoar\\\\RoarCaster.mdl\", GetManipulatingUnit(), \"origin\" ) )\r\n    endif\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Emperor takes nothing returns nothing\r\n    set gg_trg_Emperor = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Emperor, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Emperor, Condition( function Trig_Emperor_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Emperor, function Trig_Emperor_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}