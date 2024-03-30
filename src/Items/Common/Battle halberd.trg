{
  "Id": 50332404,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope BattleHalberd initializer init\r\n\r\n\tglobals\r\n\t\tpublic trigger Trigger = null\r\n\t\r\n\t\tprivate constant integer ITEM_ID = 'I025'\r\n\tendglobals\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return udg_IsDamageSpell == false\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    local unit target = AfterAttack.GetDataUnit(\"target\")\r\n\t    local unit caster = AfterAttack.GetDataUnit(\"caster\")\r\n\t    local real t = 7\r\n\t    \r\n\t    set t = timebonus( caster, t )\r\n\t    call bufst( caster, target, 'A0ZR', 'B089', \"btlh\", t )\r\n\t\r\n\t    set caster = null\r\n\t    set target = null\r\n\tendfunction\r\n\t\r\n\tpublic function Enable takes nothing returns nothing\r\n\t\tcall BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0YX' )\r\n    endfunction\r\n    \r\n    public function Disable takes nothing returns nothing\r\n\t\tcall BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0YX' )\r\n    endfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, \"caster\" )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}