{
  "Id": 50333198,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope MonkP initializer init\r\n\t\r\n\tglobals\r\n\t\tprivate constant integer ABILITY_ID = 'A08W'\r\n\t\tprivate constant integer HEAL_INITIAL = 10\r\n\t\tprivate constant integer HEAL_PER_LEVEL = 10\r\n\tendglobals\r\n\t\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return IsUnitHasAbility( AfterAttack.TriggerUnit, ABILITY_ID) and udg_IsDamageSpell == false\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t\tlocal unit caster = AfterAttack.GetDataUnit(\"caster\")\r\n\t    local unit target = null\r\n\t    local integer lvl = GetUnitAbilityLevel(caster, ABILITY_ID)\r\n\t    local real heal = HEAL_INITIAL + HEAL_PER_LEVEL * lvl\r\n\t\r\n\t    set target = HeroLessHP(caster)\r\n\t    if target != null then\r\n\t        call healst( caster, target, heal )\r\n\t        set target = null\r\n\t    endif\r\n\t    \r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    call AfterAttack.AddListener(function action, function condition)\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}