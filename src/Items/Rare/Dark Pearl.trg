{
  "Id": 50332590,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Dark_Pearl_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0ZO'\r\nendfunction\r\n\r\nfunction Trig_Dark_Pearl_Actions takes nothing returns nothing\r\n    local integer id\r\n    local unit caster\r\n    local integer x\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0ZO'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    set x = eyest( caster )\r\n    call manast( caster, null, GetUnitState( caster, UNIT_STATE_MAX_MANA) )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Items\\\\TomeOfRetraining\\\\TomeOfRetrainingCaster.mdl\", caster, \"origin\" ) )\r\n\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Dark_Pearl takes nothing returns nothing\r\n    set gg_trg_Dark_Pearl = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Dark_Pearl, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Dark_Pearl, Condition( function Trig_Dark_Pearl_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Dark_Pearl, function Trig_Dark_Pearl_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}