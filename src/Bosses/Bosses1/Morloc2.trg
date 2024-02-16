{
  "Id": 50333411,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Morloc2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n005' and GetUnitLifePercent(udg_DamageEventTarget) <= 50.\r\nendfunction\r\n\r\nfunction Trig_Morloc2_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call SetUnitAnimation( udg_DamageEventTarget, \"spell\" )\r\n    call DestroyEffect(AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\NightElf\\\\Taunt\\\\TauntCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A03C' )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Morloc2 takes nothing returns nothing\r\n    set gg_trg_Morloc2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Morloc2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Morloc2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Morloc2, Condition( function Trig_Morloc2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Morloc2, function Trig_Morloc2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}