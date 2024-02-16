{
  "Id": 50332744,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MimicOrb_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0EN'\r\nendfunction\r\n\r\nfunction Trig_MimicOrb_Actions takes nothing returns nothing\r\n\tcall MimicOrb( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MimicOrb takes nothing returns nothing\r\n    set gg_trg_MimicOrb = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MimicOrb, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_MimicOrb, Condition( function Trig_MimicOrb_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MimicOrb, function Trig_MimicOrb_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}