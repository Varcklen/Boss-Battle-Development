{
  "Id": 50332419,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Fish_Soup_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0AH'\r\nendfunction\r\n\r\nfunction Trig_Fish_Soup_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    local integer cyclB\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0AH'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set cyclAEnd = eyest( caster )\r\n    \r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        set cyclB = 1\r\n        loop\r\n            exitwhen cyclB > 4\r\n            if unitst( udg_hero[cyclB], caster, \"ally\" ) then\r\n                call healst( GetSpellAbilityUnit(), udg_hero[cyclB], 0.08 * GetUnitState( udg_hero[cyclB], UNIT_STATE_MAX_LIFE) )\r\n                call spectimeunit( udg_hero[cyclB], \"Abilities\\\\Spells\\\\Human\\\\Heal\\\\HealTarget.mdl\", \"origin\", 2 )\r\n            endif\r\n            set cyclB = cyclB + 1\r\n        endloop\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Fish_Soup takes nothing returns nothing\r\n    set gg_trg_Fish_Soup = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Fish_Soup, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Fish_Soup, Condition( function Trig_Fish_Soup_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Fish_Soup, function Trig_Fish_Soup_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}