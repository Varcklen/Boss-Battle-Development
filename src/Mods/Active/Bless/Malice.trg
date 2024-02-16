{
  "Id": 50332219,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Malice_Conditions takes nothing returns boolean\r\n    return combat( GetSpellAbilityUnit(), false, 0 ) and not( udg_fightmod[3] ) and IsUnitInGroup(GetSpellAbilityUnit(), udg_heroinfo)\r\nendfunction\r\n\r\nfunction Trig_Malice_Actions takes nothing returns nothing\r\n    call spdst( GetSpellAbilityUnit(), 0.1 )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Undead\\\\DeathPact\\\\DeathPactTarget.mdl\", GetSpellAbilityUnit(), \"origin\" ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Malice takes nothing returns nothing\r\n    set gg_trg_Malice = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Malice )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Malice, EVENT_PLAYER_UNIT_SPELL_FINISH )\r\n    call TriggerAddCondition( gg_trg_Malice, Condition( function Trig_Malice_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Malice, function Trig_Malice_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}