{
  "Id": 50332889,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Manaball_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0GC' or GetSpellAbilityId() == 'A02V'\r\nendfunction\r\n\r\nfunction Trig_Manaball_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    local real dmg\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"enemy\", \"\", \"\", \"\", \"\" )\r\n        call textst( udg_string[0] + GetObjectName('A0GC'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n\r\n    set dmg = 100 * udg_SpellDamageSpec[GetPlayerId(GetOwningPlayer(caster)) + 1]\r\n    if IsUniqueUpgraded(caster) then\r\n        set dmg = 2*dmg\r\n    endif\r\n    \r\n    call spectimeunit( target, \"Abilities\\\\Spells\\\\Undead\\\\ReplenishMana\\\\ReplenishManaCaster.mdl\", \"head\", 1 )\r\n    call UnitTakeDamage( caster, target, dmg, DAMAGE_TYPE_MAGIC)\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Manaball takes nothing returns nothing\r\n    set gg_trg_Manaball = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Manaball, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Manaball, Condition( function Trig_Manaball_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Manaball, function Trig_Manaball_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}