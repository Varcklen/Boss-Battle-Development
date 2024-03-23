{
  "Id": 50332526,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SheepTaro_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A13O' and not( udg_fightmod[3] ) and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )\r\nendfunction\r\n\r\nfunction Trig_SheepTaro_Actions takes nothing returns nothing\r\n\tlocal unit caster = GetSpellAbilityUnit()\r\n    local integer i = 1\r\n    local unit newUnit\r\n\r\n    loop\r\n        exitwhen i > 40\r\n        set newUnit = CreateUnit( GetOwningPlayer(caster), ID_SHEEP, Math_GetRandomX(GetUnitX( caster ), 400), Math_GetRandomY(GetUnitY( caster ), 400), GetRandomReal(0, 360) )\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\", GetUnitX( newUnit ), GetUnitY( newUnit ) ) )\r\n    \tcall UnitApplyTimedLife( newUnit, 'BTLF', 60 )\r\n        set i = i + 1\r\n    endloop\r\n    \r\n    call stazisst( caster, GetItemOfTypeFromUnitBJ( caster, 'I0BE') )\r\n    \r\n    set newUnit = null\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SheepTaro takes nothing returns nothing\r\n    set gg_trg_SheepTaro = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_SheepTaro, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_SheepTaro, Condition( function Trig_SheepTaro_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SheepTaro, function Trig_SheepTaro_Actions )\r\nendfunction\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}