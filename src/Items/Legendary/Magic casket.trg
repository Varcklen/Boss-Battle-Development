{
  "Id": 50332728,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Magic_casket_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0CI'\r\nendfunction\r\n\r\nfunction Trig_Magic_casket_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0CI'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set cyclAEnd = eyest( caster )\r\n\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer(caster), udg_Eczotic[GetRandomInt(1, udg_Database_NumberItems[28])], GetUnitX( caster ) + GetRandomReal( -200, 200 ), GetUnitY( caster ) + GetRandomReal( -200, 200 ), GetRandomReal( 0, 360 ) )\r\n        call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 30)\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Magic_casket takes nothing returns nothing\r\n    set gg_trg_Magic_casket = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Magic_casket, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Magic_casket, Condition( function Trig_Magic_casket_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Magic_casket, function Trig_Magic_casket_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}