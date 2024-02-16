{
  "Id": 50332773,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Kobzar_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I08X'\r\nendfunction\r\n\r\nfunction Trig_Kobzar_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIem\\\\AIemTarget.mdl\", GetManipulatingUnit(), \"origin\") )\r\n    if GetHeroInt( GetManipulatingUnit(), false) < 10000 then\r\n        call statst( GetManipulatingUnit(), 0, 0, GetHeroInt( GetManipulatingUnit(), false), 0, true )\r\n    endif\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Kobzar takes nothing returns nothing\r\n    set gg_trg_Kobzar = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Kobzar, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Kobzar, Condition( function Trig_Kobzar_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Kobzar, function Trig_Kobzar_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}