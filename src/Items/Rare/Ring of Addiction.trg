{
  "Id": 50332662,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Ring_of_Addiction_Conditions takes nothing returns boolean\r\n    return /*inv(GetSpellAbilityUnit(), 'I0G4') > 0 and*/ Uniques_Logic(GetSpellAbilityId()) and LuckChance( GetSpellAbilityUnit(), 40 )\r\nendfunction\r\n\r\nfunction Trig_Ring_of_Addiction_Actions takes nothing returns nothing\r\n    set udg_Caster = GetSpellAbilityUnit()\r\n    set udg_RandomLogic = true\r\n    call TriggerExecute( udg_DB_Trigger_Pot[GetRandomInt( 1, 10 )] )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Ring_of_Addiction takes nothing returns nothing\r\n    /*set gg_trg_Ring_of_Addiction = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Ring_of_Addiction, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Ring_of_Addiction, Condition( function Trig_Ring_of_Addiction_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Ring_of_Addiction, function Trig_Ring_of_Addiction_Actions )*/\r\n    \r\n    call RegisterDuplicatableItemType('I0G4', EVENT_PLAYER_UNIT_SPELL_EFFECT, function Trig_Ring_of_Addiction_Actions, function Trig_Ring_of_Addiction_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}