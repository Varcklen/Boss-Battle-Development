{
  "Id": 50332526,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SheepTaro_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A13O' and not( udg_fightmod[3] ) and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )\r\nendfunction\r\n\r\nfunction Trig_SheepTaro_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    \r\n    loop\r\n        exitwhen cyclA > 40\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( GetSpellAbilityUnit() ), ID_SHEEP, GetUnitX( GetSpellAbilityUnit() ), GetUnitY( GetSpellAbilityUnit() ), GetUnitFacing( GetSpellAbilityUnit() ) )\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )\r\n        call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 60 )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    call stazisst( GetSpellAbilityUnit(), GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I0BE') )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SheepTaro takes nothing returns nothing\r\n    set gg_trg_SheepTaro = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_SheepTaro, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_SheepTaro, Condition( function Trig_SheepTaro_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SheepTaro, function Trig_SheepTaro_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}