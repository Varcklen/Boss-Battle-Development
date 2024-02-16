{
  "Id": 50332530,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sheep_Staff_Conditions takes nothing returns boolean\r\n    return inv(GetSpellAbilityUnit(), 'I064') > 0 \r\nendfunction\r\n\r\nfunction Trig_Sheep_Staff_Actions takes nothing returns nothing\r\n    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( GetSpellAbilityUnit() ), ID_SHEEP, GetUnitX( GetSpellAbilityUnit() ), GetUnitY( GetSpellAbilityUnit() ), GetUnitFacing( GetSpellAbilityUnit() ) )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )\r\n    call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 60 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sheep_Staff takes nothing returns nothing\r\n    set gg_trg_Sheep_Staff = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Sheep_Staff, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Sheep_Staff, Condition( function Trig_Sheep_Staff_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Sheep_Staff, function Trig_Sheep_Staff_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}