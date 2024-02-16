{
  "Id": 50332432,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Exile_skull_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A15L'\r\nendfunction\r\n\r\nfunction Trig_Exile_skull_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A15L'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set cyclAEnd = eyest( caster ) * 5\r\n\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer(caster), 'u01I', GetUnitX( caster ) + GetRandomReal( -200, 200 ), GetUnitY( caster ) + GetRandomReal( -200, 200 ), GetRandomReal( 0, 360 ) )\r\n        call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 40)\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Exile_skull takes nothing returns nothing\r\n    set gg_trg_Exile_skull = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Exile_skull, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Exile_skull, Condition( function Trig_Exile_skull_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Exile_skull, function Trig_Exile_skull_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}