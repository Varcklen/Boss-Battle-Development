{
  "Id": 50333438,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Knight1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h000'\r\nendfunction\r\n\r\nfunction Trig_Knight1_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A01C' )\r\n    call DestroyEffect(AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Thunderclap\\\\ThunderClapCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Knight1 takes nothing returns nothing\r\n    set gg_trg_Knight1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Knight1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Knight1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Knight1, Condition( function Trig_Knight1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Knight1, function Trig_Knight1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}