{
  "Id": 50332714,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_CopyCat_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A059' and GetItemTypeId(GetSpellTargetItem()) != 'I030' and GetItemTypeId(GetSpellTargetItem()) != 'I0DI' and GetItemType(GetSpellTargetItem()) != ITEM_TYPE_POWERUP and GetItemType(GetSpellTargetItem()) != ITEM_TYPE_PURCHASABLE and GetItemType(GetSpellTargetItem()) != ITEM_TYPE_MISCELLANEOUS\r\nendfunction\r\n\r\nfunction Trig_CopyCat_Actions takes nothing returns nothing\r\n    local unit u = GetSpellAbilityUnit()\r\n    local integer h = eyest( u )\r\n    local item it = GetItemOfTypeFromUnitBJ( u, 'I0DI')\r\n    local integer itd = GetItemTypeId(GetSpellTargetItem())\r\n\r\n    call DestroyEffect(AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( u ), GetUnitY( u ) ) )\r\n    call RemoveItem ( it )\r\n    call UnitAddItem( u, CreateItem(itd, GetUnitX(u), GetUnitY(u) ) )\r\n\r\n    set it = null\r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_CopyCat takes nothing returns nothing\r\n    set gg_trg_CopyCat = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_CopyCat, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_CopyCat, Condition( function Trig_CopyCat_Conditions ) )\r\n    call TriggerAddAction( gg_trg_CopyCat, function Trig_CopyCat_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}