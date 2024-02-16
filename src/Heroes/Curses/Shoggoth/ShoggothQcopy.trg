{
  "Id": 50333366,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_ShoggothQcopy_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0YQ'\r\nendfunction\r\n\r\nfunction Trig_ShoggothQcopy_Actions takes nothing returns nothing \r\n    local unit caster\r\n    local unit target\r\n    local integer lvl\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"enemy\", \"\", \"\", \"\", \"\" )\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A0YQ'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif\r\n\r\n    call UnitAddAbility( target, 'A0ZC' )\r\n\tcall SetUnitAbilityLevel( target, 'A0ZC', lvl )\r\n\tcall UnitAddAbility( target, 'A11W' )\r\n\r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ShoggothQcopy takes nothing returns nothing\r\n    set gg_trg_ShoggothQcopy = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_ShoggothQcopy, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_ShoggothQcopy, Condition( function Trig_ShoggothQcopy_Conditions ) )\r\n    call TriggerAddAction( gg_trg_ShoggothQcopy, function Trig_ShoggothQcopy_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}