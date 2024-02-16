{
  "Id": 50332453,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_JuleItem_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0BC'\r\nendfunction\r\n\r\nfunction Trig_JuleItem_Actions takes nothing returns nothing\r\n    call JuleRef()\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetManipulatingUnit(), \"origin\" ) )\r\n    call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )\r\n    \r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_JuleItem takes nothing returns nothing\r\n    set gg_trg_JuleItem = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_JuleItem, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_JuleItem, Condition( function Trig_JuleItem_Conditions ) )\r\n    call TriggerAddAction( gg_trg_JuleItem, function Trig_JuleItem_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}