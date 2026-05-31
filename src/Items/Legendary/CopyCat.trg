{
  "Id": 50332714,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_CopyCat_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A059' and Inventory_IsCanCopied(GetSpellTargetItem()) and GetItemTypeId(GetSpellTargetItem()) != 'I0DI' and ItemManipulation_IsArtifact(GetSpellTargetItem())\r\nendfunction\r\n\r\nfunction Trig_CopyCat_Actions takes nothing returns nothing\r\n    local unit caster = GetSpellAbilityUnit()\r\n    local item itemTarget = GetSpellTargetItem()\r\n    local item itemUsed = GetItemOfTypeFromUnitBJ( caster, 'I0DI')\r\n\r\n\tcall eyest( caster )\r\n\tcall RemoveItem( itemUsed )\r\n    call DestroyEffect(AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( caster ), GetUnitY( caster ) ) )\r\n    call Inventory_CreateCopy(caster, itemTarget)\r\n\r\n    set itemUsed = null\r\n    set caster = null\r\n    set itemTarget = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_CopyCat takes nothing returns nothing\r\n    set gg_trg_CopyCat = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_CopyCat, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_CopyCat, Condition( function Trig_CopyCat_Conditions ) )\r\n    call TriggerAddAction( gg_trg_CopyCat, function Trig_CopyCat_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}