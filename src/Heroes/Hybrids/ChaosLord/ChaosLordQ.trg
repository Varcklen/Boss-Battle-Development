{
  "Id": 50333202,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_ChaosLordQ_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0F9' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )\r\nendfunction\r\n\r\nfunction Trig_ChaosLordQ_Actions takes nothing returns nothing\r\n    local integer lvl\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        set udg_logic[32] = true\r\n        call textst( udg_string[0] + GetObjectName('A0F9'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif\r\n    \r\n    /*set udg_RandomLogic = true\r\n    set udg_Caster = caster\r\n    set udg_Level = lvl\r\n    set RandomMode = true\r\n    call TriggerExecute( udg_DB_Trigger_One[GetRandomInt( 1, udg_Database_NumberItems[14])] )\r\n    set RandomMode = false*/\r\n    \r\n    call CastRandomAbility(caster, lvl, udg_DB_Trigger_One[GetRandomInt( 1, udg_Database_NumberItems[14])] )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ChaosLordQ takes nothing returns nothing\r\n    set gg_trg_ChaosLordQ = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_ChaosLordQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_ChaosLordQ, Condition( function Trig_ChaosLordQ_Conditions ) )\r\n    call TriggerAddAction( gg_trg_ChaosLordQ, function Trig_ChaosLordQ_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}