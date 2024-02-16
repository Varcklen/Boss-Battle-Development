{
  "Id": 50332813,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Granite_Science_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0PO'\r\nendfunction\r\n\r\nfunction Trig_Granite_Science_Actions takes nothing returns nothing\r\n    local integer x\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0PO'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set x = eyest( caster )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Items\\\\TomeOfRetraining\\\\TomeOfRetrainingCaster.mdl\", GetUnitX( caster ), GetUnitY( caster ) ) )\r\n    call UnitAddAbility( caster, 'A0PN' )\r\n        \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Granite_Science takes nothing returns nothing\r\n    set gg_trg_Granite_Science = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Granite_Science, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Granite_Science, Condition( function Trig_Granite_Science_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Granite_Science, function Trig_Granite_Science_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}