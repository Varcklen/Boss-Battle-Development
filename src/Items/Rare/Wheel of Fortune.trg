{
  "Id": 50332701,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Wheel_of_Fortune_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0A7'\r\nendfunction\r\n\r\nfunction Trig_Wheel_of_Fortune_Actions takes nothing returns nothing\r\n    local unit u = GetManipulatingUnit()\r\n    local integer cyclA = 0\r\n    local item it\r\n    \r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    loop\r\n        exitwhen cyclA > 5\r\n        set it = UnitItemInSlot( u, cyclA )\r\n        if it != null and GetItemType(it) != ITEM_TYPE_POWERUP and GetItemType(it) != ITEM_TYPE_PURCHASABLE then\r\n            call Inventory_ReplaceItem(GetManipulatingUnit(), it, ItemRandomizerAll( GetManipulatingUnit(), 0 ))\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() ) ) )\r\n    \r\n    set u = null\r\n    set it = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Wheel_of_Fortune takes nothing returns nothing\r\n    set gg_trg_Wheel_of_Fortune = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Wheel_of_Fortune, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Wheel_of_Fortune, Condition( function Trig_Wheel_of_Fortune_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Wheel_of_Fortune, function Trig_Wheel_of_Fortune_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}