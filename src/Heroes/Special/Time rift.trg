{
  "Id": 50332921,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Time_rift_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A1BV' \r\nendfunction\r\n\r\nfunction Trig_Time_rift_Actions takes nothing returns nothing\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A1BV'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    call coldstop( caster )\r\n    call DestroyEffect( AddSpecialEffect( \"war3mapImported\\\\Sci Teleport.mdx\", GetUnitX( caster ), GetUnitY( caster ) ) )\r\n    \r\n    if combat( caster, false, 0 ) then\r\n        call NewSpecial( caster, 'A1BW' )\r\n    endif\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Time_rift takes nothing returns nothing\r\n    set gg_trg_Time_rift = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Time_rift, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Time_rift, Condition( function Trig_Time_rift_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Time_rift, function Trig_Time_rift_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}