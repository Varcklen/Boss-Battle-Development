{
  "Id": 50332672,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sea_Pearl_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A02P'\r\nendfunction\r\n\r\nfunction Trig_Sea_Pearl_Actions takes nothing returns nothing\r\n    local integer x\r\n    local integer cyclA = 1\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A02P'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set x = eyest( caster )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 and unitst( udg_hero[cyclA], caster, \"ally\" ) then\r\n            call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Items\\\\TomeOfRetraining\\\\TomeOfRetrainingCaster.mdl\", GetUnitX( udg_hero[cyclA] ), GetUnitY( udg_hero[cyclA] ) ) )\r\n            call UnitAddAbility( udg_hero[cyclA], 'A054' )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n        \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sea_Pearl takes nothing returns nothing\r\n    set gg_trg_Sea_Pearl = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Sea_Pearl, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Sea_Pearl, Condition( function Trig_Sea_Pearl_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Sea_Pearl, function Trig_Sea_Pearl_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}