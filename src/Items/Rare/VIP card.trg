{
  "Id": 50332697,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_VIP_card_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0GB'\r\nendfunction\r\n\r\nfunction Trig_VIP_card_Actions takes nothing returns nothing\r\n    call JuleUpgradeUse()\r\n    call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() ) ) )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_VIP_card takes nothing returns nothing\r\n    set gg_trg_VIP_card = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_VIP_card, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_VIP_card, Condition( function Trig_VIP_card_Conditions ) )\r\n    call TriggerAddAction( gg_trg_VIP_card, function Trig_VIP_card_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}