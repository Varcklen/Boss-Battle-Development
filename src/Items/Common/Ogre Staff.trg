{
  "Id": 50332489,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope OgreStaff initializer init\r\n\r\n\tglobals\r\n\t\tpublic trigger Trigger = null\r\n\t\r\n\t\tprivate constant integer ITEM_ID = 'I09F'\r\n\tendglobals\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return udg_IsDamageSpell == false and IsUnitType( AfterAttack.GetDataUnit(\"target\"), UNIT_TYPE_HERO) == false and IsUnitType( AfterAttack.GetDataUnit(\"target\"), UNIT_TYPE_ANCIENT) == false\r\n\tendfunction\r\n\r\n\tprivate function action takes nothing returns nothing\r\n\t    local unit caster = AfterAttack.GetDataUnit(\"caster\")\r\n\r\n\t    call manast( caster, null, 5 )\r\n    \tcall DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\ReplenishMana\\\\SpiritTouchTarget.mdl\", caster, \"origin\") )\r\n\r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\tpublic function Enable takes nothing returns nothing\r\n\t\tcall BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0WH' )\r\n    endfunction\r\n    \r\n    public function Disable takes nothing returns nothing\r\n\t\tcall BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0WH' )\r\n    endfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, \"caster\" )\r\n\tendfunction\r\n\t\r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}