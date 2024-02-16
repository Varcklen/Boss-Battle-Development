{
  "Id": 50333424,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": true,
  "Script": "//TESH.scrollpos=0\r\n//TESH.alwaysfold=0\r\nfunction Trig_DrunkMan3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n02U' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_DrunkMan3_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call DestroyEffect(AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\NightElf\\\\Taunt\\\\TauntCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A13Q' )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DrunkMan3 takes nothing returns nothing\r\n    set gg_trg_DrunkMan3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_DrunkMan3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_DrunkMan3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_DrunkMan3, Condition( function Trig_DrunkMan3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_DrunkMan3, function Trig_DrunkMan3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}