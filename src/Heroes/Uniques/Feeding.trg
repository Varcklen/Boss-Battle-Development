{
  "Id": 50332894,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Feeding initializer init\r\n\r\n\tglobals\r\n\t\tprivate constant string ANIMATION = \"Abilities\\\\Spells\\\\Human\\\\Heal\\\\HealTarget.mdl\"\r\n\t\t\r\n\t\tprivate constant real HEAL_PERCENT = 0.5\r\n\t\tprivate constant real HEAL_PERCENT_UPGRADED = 1\r\n\t\t\r\n\t\tprivate constant integer ATTACK_GAIN = 5\r\n\t\tprivate constant integer ATTACK_GAIN_UPGRADED = 10\r\n\t\t\r\n\t\tprivate constant integer ABILITY_ID = 'A0MW'\r\n\t\tprivate constant integer UPGRADED_ABILITY_ID = 'A084'\r\n\tendglobals\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return GetSpellAbilityId() == ABILITY_ID or GetSpellAbilityId() == UPGRADED_ABILITY_ID\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    local integer lvl\r\n\t    local real multiplier\r\n\t    local integer attackGain\r\n\t    local real heal\r\n\t    local unit caster\r\n\t    local unit target\r\n\t  \r\n\t    if CastLogic() then\r\n\t        set caster = udg_Caster\r\n\t        set target = udg_Target\r\n\t    elseif RandomLogic() then\r\n\t        set caster = udg_Caster\r\n\t        set target = randomtarget( caster, 900, \"ally\", \"pris\", \"notfull\", \"\", \"\" )\r\n\t        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )\r\n\t        if target == null then\r\n\t            set caster = null\r\n\t            return\r\n\t        endif\r\n\t    else\r\n\t        set caster = GetSpellAbilityUnit()\r\n\t        set target = GetSpellTargetUnit()\r\n\t    endif\r\n\t    \r\n\t    if IsUnitType( target, UNIT_TYPE_ANCIENT) == false and IsUnitType( target, UNIT_TYPE_HERO) == false then\r\n\t        if IsUniqueUpgraded(caster) then\r\n\t            set multiplier = HEAL_PERCENT_UPGRADED\r\n\t            set attackGain = ATTACK_GAIN_UPGRADED\r\n            else\r\n            \tset multiplier = HEAL_PERCENT\r\n            \tset attackGain = ATTACK_GAIN\r\n\t        endif\r\n\t\r\n\t        set heal = GetUnitState( target, UNIT_STATE_MAX_LIFE) * multiplier\r\n\t        call BlzSetUnitBaseDamage( target, BlzGetUnitBaseDamage(target, 0) + attackGain, 0 )\r\n\t        \r\n\t        call healst( caster, target, heal )\r\n\t        call spectimeunit( target, ANIMATION, \"origin\", 2 )\r\n\t    endif\r\n\t    \r\n\t    set target = null\r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    set gg_trg_Feeding = CreateTrigger(  )\r\n\t    call TriggerRegisterAnyUnitEventBJ( gg_trg_Feeding, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n\t    call TriggerAddCondition( gg_trg_Feeding, Condition( function condition ) )\r\n\t    call TriggerAddAction( gg_trg_Feeding, function action )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}