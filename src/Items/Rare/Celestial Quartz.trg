{
  "Id": 50332581,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Celestial_Quartz_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0XN' and not( udg_fightmod[3] ) and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )\r\nendfunction\r\n\r\nfunction Trig_Celestial_Quartz_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0XN'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set cyclAEnd = eyest( caster )\r\n\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call BlzSetUnitMaxMana( caster, BlzGetUnitMaxMana(caster) + 20 )\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Items\\\\AIma\\\\AImaTarget.mdl\", GetUnitX( caster ), GetUnitY( caster ) ) )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Celestial_Quartz takes nothing returns nothing\r\n    set gg_trg_Celestial_Quartz = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Celestial_Quartz, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Celestial_Quartz, Condition( function Trig_Celestial_Quartz_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Celestial_Quartz, function Trig_Celestial_Quartz_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}