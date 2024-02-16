{
  "Id": 50333133,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MiracleBrewQ_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0R1'\r\nendfunction\r\n\r\nfunction Trig_MiracleBrewQ_Actions takes nothing returns nothing\r\n    local integer lvl\r\n    local unit caster\r\n    local integer rand\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        set udg_logic[32] = true\r\n        call textst( udg_string[0] + GetObjectName('A0R1'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif\r\n    set udg_Caster = caster\r\n    set udg_Target = null\r\n    set udg_RandomLogic = true\r\n    set udg_CastLogic = false\r\n    if lvl == 1 or lvl == 2 then\r\n        set rand = GetRandomInt( 1, 4 )\r\n    elseif lvl == 3 or lvl == 4 then\r\n        set rand = GetRandomInt( 1, 8 )\r\n    elseif lvl == 5 then\r\n        set rand = GetRandomInt( 1, 10 )\r\n    endif\r\n    set RandomMode = true\r\n    call TriggerExecute( udg_DB_Trigger_Pot[rand] )\r\n    set RandomMode = false\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MiracleBrewQ takes nothing returns nothing\r\n    set gg_trg_MiracleBrewQ = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MiracleBrewQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_MiracleBrewQ, Condition( function Trig_MiracleBrewQ_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MiracleBrewQ, function Trig_MiracleBrewQ_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}