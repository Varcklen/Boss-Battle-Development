{
  "Id": 50332476,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Mystery_box_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0FC'\r\nendfunction\r\n\r\nfunction Trig_Mystery_box_Actions takes nothing returns nothing\r\n    local unit u = GetManipulatingUnit()\r\n    local integer index = LoadInteger( udg_hash, GetHandleId(GetManipulatedItem()), StringHash( \"modbad25\" ) )\r\n    \r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( u ), GetUnitY( u ) ) )\r\n    call RemoveSavedInteger(udg_hash, GetHandleId( GetManipulatedItem() ), StringHash( \"modbad25\" ) )\r\n    call RemoveItem( GetManipulatedItem() )\r\n    call UnitAddItem(u, CreateItem(index, GetUnitX(u), GetUnitY(u)))\r\n    \r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Mystery_box takes nothing returns nothing\r\n    set gg_trg_Mystery_box = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Mystery_box, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Mystery_box, Condition( function Trig_Mystery_box_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Mystery_box, function Trig_Mystery_box_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}