{
  "Id": 50333515,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Golem3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n00R' and GetUnitLifePercent(udg_DamageEventTarget) <= 25.\r\nendfunction\r\n\r\nfunction Trig_Golem3_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call SetUnitAbilityLevel( udg_DamageEventTarget, 'A0B0', 2)\r\n    call DestroyEffect(AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Orc\\\\WarStomp\\\\WarStompCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\n\r\n    call Golem1_SummonTotems(udg_DamageEventTarget, 8)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Golem3 takes nothing returns nothing\r\n    set gg_trg_Golem3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Golem3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Golem3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Golem3, Condition( function Trig_Golem3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Golem3, function Trig_Golem3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}