{
  "Id": 50333211,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_DryadEC_Conditions takes nothing returns boolean\r\n    return luckylogic( GetSpellAbilityUnit(), 1+GetUnitAbilityLevel( GetSpellAbilityUnit(), 'A0I9'), 1, 100 ) and not( udg_fightmod[3] ) and GetUnitAbilityLevel( GetSpellAbilityUnit(), 'A0I9') > 0 and combat( GetSpellAbilityUnit(), false, 0 )\r\nendfunction\r\n\r\nfunction Trig_DryadEC_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIem\\\\AIemTarget.mdl\", GetSpellAbilityUnit(), \"origin\") )\r\n    call statst( GetSpellAbilityUnit(), 0, 0, 1, 208, true )\r\n    call textst( \"|c002020FF +1 intelligence\", GetSpellAbilityUnit(), 64, 90, 10, 1 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DryadEC takes nothing returns nothing\r\n    set gg_trg_DryadEC = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_DryadEC, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_DryadEC, Condition( function Trig_DryadEC_Conditions ) )\r\n    call TriggerAddAction( gg_trg_DryadEC, function Trig_DryadEC_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}