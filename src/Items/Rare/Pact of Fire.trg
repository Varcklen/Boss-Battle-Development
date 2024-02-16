{
  "Id": 50332655,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Pact_of_Fire_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0FF'\r\nendfunction\r\n\r\nfunction Trig_Pact_of_Fire_Actions takes nothing returns nothing    \r\n    call SpellUniqueUnit(GetManipulatingUnit(), 25)\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Demon\\\\DarkPortal\\\\DarkPortalTarget.mdl\", GetManipulatingUnit(), \"origin\") )\r\n    call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Pact_of_Fire takes nothing returns nothing\r\n    set gg_trg_Pact_of_Fire = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Pact_of_Fire, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Pact_of_Fire, Condition( function Trig_Pact_of_Fire_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Pact_of_Fire, function Trig_Pact_of_Fire_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}