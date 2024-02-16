{
  "Id": 50332611,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_KillAltar_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A02Q' and combat( GetSpellAbilityUnit(), true, 'A02Q' )\r\nendfunction\r\n\r\nfunction Trig_KillAltar_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local integer x\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A02Q'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    set x = eyest( caster )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIso\\\\AIsoTarget.mdl\", caster, \"origin\") )\r\n    call dummyspawn( caster, 0, 'A02R', 'A02S', 0 )\r\n    call KillUnit( caster )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_KillAltar takes nothing returns nothing\r\n    set gg_trg_KillAltar = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_KillAltar, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_KillAltar, Condition( function Trig_KillAltar_Conditions ) )\r\n    call TriggerAddAction( gg_trg_KillAltar, function Trig_KillAltar_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}