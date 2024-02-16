{
  "Id": 50333359,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_ShoggothEC_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel( GetSpellAbilityUnit(), 'A198' ) > 0 and GetUnitTypeId(GetSpellAbilityUnit()) != 'u000' and luckylogic( GetSpellAbilityUnit(), 1 + GetUnitAbilityLevel( GetSpellAbilityUnit(), 'A198'), 1, 100 )\r\nendfunction\r\n\r\nfunction Trig_ShoggothEC_Actions takes nothing returns nothing\r\n    call ShoggothTent( GetSpellAbilityUnit() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ShoggothEC takes nothing returns nothing\r\n    set gg_trg_ShoggothEC = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_ShoggothEC, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_ShoggothEC, Condition( function Trig_ShoggothEC_Conditions ) )\r\n    call TriggerAddAction( gg_trg_ShoggothEC, function Trig_ShoggothEC_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}