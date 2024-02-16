{
  "Id": 50332450,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Gift_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I02W'\r\nendfunction\r\n\r\nfunction Trig_Gift_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() ) ) )\r\n    call moneyst( GetManipulatingUnit(), 250 )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    call ItemRandomizer( GetManipulatingUnit(), \"common\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Gift takes nothing returns nothing\r\n    set gg_trg_Gift = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Gift, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Gift, Condition( function Trig_Gift_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Gift, function Trig_Gift_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}