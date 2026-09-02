{
  "Id": 50332624,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Muta_Mushroom_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0OB'\r\nendfunction\r\n\r\nfunction Trig_Muta_Mushroom_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd \r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0OB'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set cyclAEnd = 3 * eyest( caster )\r\n\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), udg_Database_RandomUnit[GetRandomInt(1, udg_Database_NumberItems[5])], GetUnitX( caster ) + GetRandomReal( -200, 200 ), GetUnitY( caster ) + GetRandomReal( -200, 200 ), GetRandomReal( 0, 360 ) )\r\n        call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 30)\r\n        call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\", bj_lastCreatedUnit, \"origin\" ) )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Muta_Mushroom takes nothing returns nothing\r\n    set gg_trg_Muta_Mushroom = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Muta_Mushroom, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Muta_Mushroom, Condition( function Trig_Muta_Mushroom_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Muta_Mushroom, function Trig_Muta_Mushroom_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}