{
  "Id": 50332805,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_OrbTreantHeal_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A190' or GetSpellAbilityId() == 'A192'\r\nendfunction\r\n\r\nfunction Trig_OrbTreantHeal_Actions takes nothing returns nothing\r\n    local unit caster = GetSpellAbilityUnit()\r\n    local unit target = GetSpellTargetUnit()\r\n    local real heal\r\n\r\n    if GetSpellAbilityId() == 'A190' then\r\n        call healst( caster, target, 75 )    \r\n        call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\HolyBolt\\\\HolyBoltSpecialArt.mdl\" , target, \"origin\" ) )\r\n    else\r\n        call manast( caster, target, 30 )\r\n        call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Items\\\\AIma\\\\AImaTarget.mdl\" , target, \"origin\" ) )\r\n    endif\r\n    call KillUnit(caster)\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_OrbTreantHeal takes nothing returns nothing\r\n    set gg_trg_OrbTreantHeal = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_OrbTreantHeal, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_OrbTreantHeal, Condition( function Trig_OrbTreantHeal_Conditions ) )\r\n    call TriggerAddAction( gg_trg_OrbTreantHeal, function Trig_OrbTreantHeal_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}