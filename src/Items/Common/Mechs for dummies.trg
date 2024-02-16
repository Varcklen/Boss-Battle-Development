{
  "Id": 50332474,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Mechs_for_dummies_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A00G' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )\r\nendfunction\r\n  \r\nfunction Trig_Mechs_for_dummies_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set udg_logic[32] = true\r\n        call textst( udg_string[0] + GetObjectName('A00G'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    set cyclAEnd = eyest(caster)\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n    \tset udg_Caster = caster\r\n    \tset udg_RandomLogic = true\r\n        set RandomMode = true\r\n        call TriggerExecute( udg_DB_MechUse[GetRandomInt( 1, udg_Database_NumberItems[35])] )\r\n        set RandomMode = false\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Mechs_for_dummies takes nothing returns nothing\r\n    set gg_trg_Mechs_for_dummies = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Mechs_for_dummies, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Mechs_for_dummies, Condition( function Trig_Mechs_for_dummies_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Mechs_for_dummies, function Trig_Mechs_for_dummies_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}