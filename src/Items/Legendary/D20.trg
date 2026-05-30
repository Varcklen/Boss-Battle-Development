{
  "Id": 50332745,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_D20_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0FB' and combat( GetManipulatingUnit(), true, 0 ) and not(udg_fightmod[3])\r\nendfunction\r\n\r\nfunction Trig_D20_Actions takes nothing returns nothing\r\n    local unit caster = GetManipulatingUnit()\r\n    local item itemUsed = GetManipulatedItem()\r\n    local item it\r\n    local integer i\r\n    local integer newItemType\r\n\r\n    call eyest( caster )\r\n    set i = 0\r\n    loop\r\n        exitwhen i > 5\r\n        set it = UnitItemInSlot( caster, i )\r\n        if it != null and it != itemUsed and ItemManipulation_IsArtifact(it) then\r\n        \tset newItemType = ItemRandomizerLib_GetRandomItemType()\r\n            call Inventory_ReplaceItemByNew(caster, it, newItemType )\r\n        endif\r\n        set i = i + 1\r\n    endloop\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( caster ), GetUnitY( caster ) ) )\r\n    \r\n    set caster = null\r\n    set it = null\r\n    set itemUsed = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_D20 takes nothing returns nothing\r\n    set gg_trg_D20 = CreateTrigger()\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_D20, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_D20, Condition( function Trig_D20_Conditions ) )\r\n    call TriggerAddAction( gg_trg_D20, function Trig_D20_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}