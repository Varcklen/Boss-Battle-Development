{
  "Id": 50332893,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Chaos_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0IS' or GetSpellAbilityId() == 'A0IV' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() ) and not( udg_fightmod[3] )\r\nendfunction\r\n\r\nfunction Trig_Chaos_Actions takes nothing returns nothing\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set udg_logic[32] = true\r\n        call textst( udg_string[0] + GetObjectName('A0IS'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    call CastLib_CastRandomAbility( caster, udg_DB_Trigger_Spec[GetRandomInt( 1, udg_Database_NumberItems[24] )], 1 )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Chaos takes nothing returns nothing\r\n    set gg_trg_Chaos = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Chaos, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Chaos, Condition( function Trig_Chaos_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Chaos, function Trig_Chaos_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}