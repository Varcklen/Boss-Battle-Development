{
  "Id": 50332535,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Sundial initializer init\r\n\r\n\tglobals\r\n\t\tprivate constant integer ITEM_ID = 'I017'\r\n\t\t\r\n\t\tprivate constant integer CHANCE = 8\r\n\t\tprivate constant integer LIFE_TIME = 15\r\n\t\t\r\n\t\tprivate constant integer SPAWN_DEVIATION = 200\r\n\t\t\r\n\t\tprivate constant string ANIMATION = \"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\"\r\n\tendglobals\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return not( udg_IsDamageSpell ) and LuckChance( AfterAttack.TriggerUnit, CHANCE )\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t\tlocal unit caster = AfterAttack.GetDataUnit(\"caster\")\r\n\t\tlocal unit newUnit\r\n\t\tlocal real facing = GetUnitFacing(caster)\r\n\t\tlocal integer unitType = udg_Database_RandomUnit[GetRandomInt(1, udg_Database_NumberItems[5])]\r\n\t    \r\n\t    set newUnit = CreateUnit( Player(4), unitType, Math_GetUnitRandomX( caster, SPAWN_DEVIATION), Math_GetUnitRandomY( caster, SPAWN_DEVIATION), facing )\r\n        call UnitApplyTimedLife( newUnit, 'BTLF', LIFE_TIME)\r\n        call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( newUnit ), GetUnitY( newUnit ) ) )\r\n\t    \r\n\t    set newUnit = null\r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, \"caster\" )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}