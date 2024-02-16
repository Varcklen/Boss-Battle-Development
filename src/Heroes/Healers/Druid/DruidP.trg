{
  "Id": 50333292,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_DruidP_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel(GetSpellAbilityUnit(), 'A00F') > 0 and luckylogic( GetSpellAbilityUnit(), 10 + ( 8 * GetUnitAbilityLevel(GetSpellAbilityUnit(), 'A00F') ), 1, 100 )\r\nendfunction\r\n\r\nfunction Trig_DruidP_Actions takes nothing returns nothing\r\n    call healst( GetSpellAbilityUnit(), null, 50 )\r\n    call manast( GetSpellAbilityUnit(), null, 50 )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Items\\\\AIil\\\\AIilTarget.mdl\", GetSpellAbilityUnit(), \"origin\" ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DruidP takes nothing returns nothing\r\n    set gg_trg_DruidP = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_DruidP, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_DruidP, Condition( function Trig_DruidP_Conditions ) )\r\n    call TriggerAddAction( gg_trg_DruidP, function Trig_DruidP_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}