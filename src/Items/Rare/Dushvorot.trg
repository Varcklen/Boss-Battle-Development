{
  "Id": 50332589,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Dushvorot_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0OO'\r\nendfunction\r\n\r\nfunction Trig_Dushvorot_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd \r\n    local real mp\r\n    local real hp\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0OO'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    set cyclAEnd = eyest( caster )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\MarkOfChaos\\\\MarkOfChaosTarget.mdl\", caster, \"origin\" ) )\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        set hp = GetUnitState( caster, UNIT_STATE_LIFE) / RMaxBJ(0,GetUnitState( caster, UNIT_STATE_MAX_LIFE))\r\n        set mp = GetUnitState( caster, UNIT_STATE_MANA) / RMaxBJ(0,GetUnitState( caster, UNIT_STATE_MAX_MANA))\r\n        call SetUnitState( caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * mp)\r\n        call SetUnitState( caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MAX_MANA) * hp)\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Dushvorot takes nothing returns nothing\r\n    set gg_trg_Dushvorot = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Dushvorot, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Dushvorot, Condition( function Trig_Dushvorot_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Dushvorot, function Trig_Dushvorot_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}