{
  "Id": 50332399,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Big_Surprise_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0A1'\r\nendfunction\r\n\r\nfunction Trig_Big_Surprise_Actions takes nothing returns nothing\r\n\tlocal unit caster = GetManipulatingUnit()\r\n\tlocal item itemCheck = null\r\n    local integer i = 0\r\n    local integer itemsToGain = 4\r\n    \r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( caster ), GetUnitY( caster ) ) )\r\n    call stazisst( caster, GetManipulatedItem() )\r\n    \r\n    set i = 0\r\n    loop\r\n        exitwhen i > 5\r\n        set itemCheck = UnitItemInSlot( caster, i)\r\n        if itemCheck != null and GetItemType(itemCheck) != ITEM_TYPE_POWERUP and GetItemType(itemCheck) != ITEM_TYPE_PURCHASABLE then\r\n            set itemsToGain = itemsToGain - 1\r\n        endif\r\n        set i = i + 1\r\n    endloop\r\n    \r\n    set itemsToGain = IMaxBJ(1, itemsToGain)\r\n    \r\n    set i = 1\r\n    loop\r\n        exitwhen i > itemsToGain or ItemManipulation_IsInventoryFull(caster)\r\n        call ItemRandomizerAll( caster, 0 )\r\n        set i = i + 1\r\n    endloop\r\n    \r\n    set caster = null\r\n    set itemCheck = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Big_Surprise takes nothing returns nothing\r\n    set gg_trg_Big_Surprise = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Big_Surprise, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Big_Surprise, Condition( function Trig_Big_Surprise_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Big_Surprise, function Trig_Big_Surprise_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}