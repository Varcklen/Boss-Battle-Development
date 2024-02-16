{
  "Id": 50333505,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Chief4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'h01X' and GetUnitLifePercent(udg_DamageEventTarget) <= 35\r\nendfunction\r\n\r\nfunction Trig_Chief4_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A16X' )\r\n    call DestroyEffect(AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Thunderclap\\\\ThunderClapCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Chief4 takes nothing returns nothing\r\n    set gg_trg_Chief4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Chief4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Chief4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Chief4, Condition( function Trig_Chief4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Chief4, function Trig_Chief4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}