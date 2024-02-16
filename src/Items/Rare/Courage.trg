{
  "Id": 50332578,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Courage_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0BD'\r\nendfunction\r\n\r\nfunction Trig_Courage_Actions takes nothing returns nothing                \r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Avatar\\\\AvatarCaster.mdl\", GetManipulatingUnit(), \"origin\") )\r\n    call statst( GetManipulatingUnit(), 3, 3, 3, 0, true )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Courage takes nothing returns nothing\r\n    set gg_trg_Courage = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Courage, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Courage, Condition( function Trig_Courage_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Courage, function Trig_Courage_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}