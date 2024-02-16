{
  "Id": 50333004,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MinW_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0DW'\r\nendfunction\r\n\r\nfunction Trig_MinW_Actions takes nothing returns nothing\r\n    local real r \r\n    local integer lvl\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A0DW'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif    \r\n    set r = GetUnitState( caster, UNIT_STATE_MANA ) / 2\r\n    call healst( caster, null, r * ( 1 + lvl ) )\r\n    call spectimeunit( caster, \"Abilities\\\\Spells\\\\Orc\\\\AncestralSpirit\\\\AncestralSpiritCaster.mdl\", \"origin\", 1.5 ) \r\n    call SetUnitState( caster, UNIT_STATE_MANA, RMaxBJ(0,GetUnitState( caster, UNIT_STATE_MANA) - r ) )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MinW takes nothing returns nothing\r\n    set gg_trg_MinW = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MinW, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_MinW, Condition( function Trig_MinW_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MinW, function Trig_MinW_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}