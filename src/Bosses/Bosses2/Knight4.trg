{
  "Id": 50333441,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Knight4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h000' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_Knight4_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call SetUnitAbilityLevel(udg_DamageEventTarget, 'A03D', 4)\r\n    call SetUnitAbilityLevel(udg_DamageEventTarget, 'A01E', 4)\r\n    call SetUnitAnimation( udg_DamageEventTarget, \"stand victory\" )\r\n    call DestroyEffect(AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Thunderclap\\\\ThunderClapCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Knight4 takes nothing returns nothing\r\n    set gg_trg_Knight4 = CreateTrigger()\r\n    call DisableTrigger( gg_trg_Knight4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Knight4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Knight4, Condition( function Trig_Knight4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Knight4, function Trig_Knight4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}