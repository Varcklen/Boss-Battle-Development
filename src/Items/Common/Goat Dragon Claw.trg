{
  "Id": 50332449,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope GoatDragonClaw initializer init\r\n\r\n\tglobals\r\n\t\tpublic trigger Trigger = null\r\n\t\r\n\t\tprivate constant integer ITEM_ID = 'I0GA'\r\n\t\t\r\n\t\tprivate constant integer UNIQUE_SPELL_POWER_GAIN = 20\r\n\t\tprivate constant integer STACK_LIMIT = 10\r\n\tendglobals\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return not( udg_IsDamageSpell ) and combat( AfterAttack.TriggerUnit, false, 0 ) and luckylogic( AfterAttack.TriggerUnit, 10, 1, 100 )\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    local unit caster = AfterAttack.GetDataUnit(\"caster\")\r\n\t    local integer id = GetHandleId( caster )\r\n\t    local integer k = LoadInteger( udg_hash, id, StringHash( \"dgca\" ) )\r\n\r\n\t    if k < STACK_LIMIT then\r\n\t        call UnitAddAbility( caster, 'A1AH' )\r\n\t        set k = k + 1\r\n\t        call SaveInteger( udg_hash, id, StringHash( \"dgca\" ), k )\r\n\t        call SpellUniqueUnit( caster, UNIQUE_SPELL_POWER_GAIN)\r\n\t        call textst( \"|cff60C445 +\" + I2S( k * UNIQUE_SPELL_POWER_GAIN) + \"%\", caster, 64, 90, 10, 1 )\r\n\t        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Items\\\\AIem\\\\AIemTarget.mdl\", GetUnitX( caster ), GetUnitY( caster ) ) )\r\n\t    endif\r\n\t    \r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, \"caster\" )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}