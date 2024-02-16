{
  "Id": 50332559,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_BalanceSub_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A050'\r\nendfunction\r\n\r\nfunction Trig_BalanceSub_Actions takes nothing returns nothing\r\n    local integer x\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A050'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set x = eyest( caster )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"war3mapImported\\\\HolyAwakening.mdx\", caster, \"origin\") )\r\n    call SetUnitState( caster, UNIT_STATE_LIFE, GetUnitState( caster, UNIT_STATE_MAX_LIFE) * 0.5 )\r\n    call SetUnitState( caster, UNIT_STATE_MANA, GetUnitState( caster, UNIT_STATE_MAX_MANA) * 0.5 )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_BalanceSub takes nothing returns nothing\r\n    set gg_trg_BalanceSub = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_BalanceSub, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_BalanceSub, Condition( function Trig_BalanceSub_Conditions ) )\r\n    call TriggerAddAction( gg_trg_BalanceSub, function Trig_BalanceSub_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}