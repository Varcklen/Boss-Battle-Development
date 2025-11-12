{
  "Id": 50332773,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Kobzar_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I08X'\r\nendfunction\r\n\r\nfunction Trig_Kobzar_Actions takes nothing returns nothing\r\n\tlocal integer bonus = 10\r\n\tlocal real mult = 0.5\r\n\tlocal unit caster = GetManipulatingUnit()\r\n\t\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIem\\\\AIemTarget.mdl\", GetManipulatingUnit(), \"origin\") )\r\n    if GetHeroInt( caster, false) < 10000 then\r\n    \tset bonus = bonus + R2I( GetHeroInt( caster, false) * mult )\r\n        call statst( caster, 0, 0, bonus, 0, true )\r\n    endif\r\n    call stazisst( caster, GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Kobzar takes nothing returns nothing\r\n    set gg_trg_Kobzar = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Kobzar, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Kobzar, Condition( function Trig_Kobzar_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Kobzar, function Trig_Kobzar_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}