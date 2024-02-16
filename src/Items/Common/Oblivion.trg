{
  "Id": 50332490,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Oblivion_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I05Y'\r\nendfunction\r\n\r\nfunction Trig_Oblivion_Actions takes nothing returns nothing\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )\r\n    call delspellpas(GetManipulatingUnit())\r\n    call UnitAddItem(GetManipulatingUnit(), CreateItem( 'I01M', GetUnitX(GetManipulatingUnit()), GetUnitY(GetManipulatingUnit())))\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Oblivion takes nothing returns nothing\r\n    set gg_trg_Oblivion = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Oblivion, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Oblivion, Condition( function Trig_Oblivion_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Oblivion, function Trig_Oblivion_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}