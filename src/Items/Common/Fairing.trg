{
  "Id": 50332418,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Fairing_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I065'\r\nendfunction\r\n\r\nfunction Trig_Fairing_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetManipulatingUnit(), \"origin\" ) )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    call ItemRandomizer( GetManipulatingUnit(), \"rare\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Fairing takes nothing returns nothing\r\n    set gg_trg_Fairing = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Fairing, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Fairing, Condition( function Trig_Fairing_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Fairing, function Trig_Fairing_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}