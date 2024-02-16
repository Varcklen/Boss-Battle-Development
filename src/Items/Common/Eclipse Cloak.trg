{
  "Id": 50332426,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Eclipse_Cloak_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0ZS'\r\nendfunction\r\n\r\nfunction Trig_Eclipse_Cloak_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd \r\n    local real mp\r\n\r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0ZS'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    if udg_Set_Moon_Number[GetPlayerId(GetOwningPlayer(caster)) + 1] > 1 then\r\n        set mp = GetUnitState( caster, UNIT_STATE_MAX_MANA) * 0.20\r\n    else\r\n        set mp = GetUnitState( caster, UNIT_STATE_MAX_MANA) * 0.10\r\n    endif\r\n    \r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIma\\\\AImaTarget.mdl\", caster, \"origin\") )\r\n    set cyclAEnd = eyest( caster )\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call manast( caster, null, mp )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Eclipse_Cloak takes nothing returns nothing\r\n    set gg_trg_Eclipse_Cloak = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Eclipse_Cloak, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Eclipse_Cloak, Condition( function Trig_Eclipse_Cloak_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Eclipse_Cloak, function Trig_Eclipse_Cloak_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}