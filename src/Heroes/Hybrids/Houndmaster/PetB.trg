{
  "Id": 50333191,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope HoundmasterBite initializer init\r\n\r\n\tglobals\r\n\t\tprivate constant integer ABILITY_ID = 'A0ND'\r\n\t\tprivate constant integer DAMAGE = 100\r\n\t\t\r\n\t\tprivate constant string ANIMATION = \"Abilities\\\\Spells\\\\Other\\\\Stampede\\\\StampedeMissileDeath.mdl\"\r\n\tendglobals\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return GetSpellAbilityId() == ABILITY_ID\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t\tlocal unit caster = GetSpellAbilityUnit()\r\n\t\tlocal unit target = GetSpellTargetUnit()\r\n\t\tlocal unit owner = LoadUnitHandle( udg_hash, GetHandleId( caster ), StringHash( \"houndmaster_r_owner\" ) )\r\n\t\tlocal integer damageIncrease = LoadInteger( udg_hash, GetHandleId( owner ), StringHash(\"houndmaster_q_damage_increase\") )\r\n\t    local real damage = DAMAGE + damageIncrease\r\n\t\r\n\t    call UnitDamageTarget( caster, target, damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n\t    call DestroyEffect( AddSpecialEffectTarget( ANIMATION, target, \"origin\" ) )\r\n\t    \r\n\t    set caster = null\r\n\t    set owner = null\r\n\t    set target = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    local trigger trig = CreateTrigger(  )\r\n\t    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n\t    call TriggerAddCondition( trig, Condition( function condition ) )\r\n\t    call TriggerAddAction( trig, function action )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}