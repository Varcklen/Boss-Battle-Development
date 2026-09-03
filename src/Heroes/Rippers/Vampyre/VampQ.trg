{
  "Id": 50333039,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_VampQ_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A065'\r\nendfunction\r\n\r\nfunction Trig_VampQ_Actions takes nothing returns nothing\r\n    local integer lvl\r\n    local unit caster\r\n    local real dmg \r\n\r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A065'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif\r\n    \r\n    set dmg = 100 + 40 * lvl\r\n    call DestroyEffect( AddSpecialEffect( \"war3mapImported\\\\BloodSlam.mdx\", GetUnitX(caster), GetUnitY(caster) ) )\r\n    call GroupAoE( caster,  GetUnitX(caster), GetUnitY(caster), dmg, 300, \"enemy\", null, null )\r\n    \r\n    call SetUnitState( caster, UNIT_STATE_LIFE, RMaxBJ(0,GetUnitState( caster, UNIT_STATE_LIFE) - 80 ))\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_VampQ takes nothing returns nothing\r\n    set gg_trg_VampQ = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_VampQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_VampQ, Condition( function Trig_VampQ_Conditions ) )\r\n    call TriggerAddAction( gg_trg_VampQ, function Trig_VampQ_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}