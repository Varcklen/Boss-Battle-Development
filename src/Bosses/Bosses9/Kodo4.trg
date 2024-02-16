{
  "Id": 50333638,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Kodo4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h01K' and GetUnitLifePercent(udg_DamageEventTarget) <= 40\r\nendfunction\r\n\r\nfunction Trig_Kodo4_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\NightElf\\\\BattleRoar\\\\RoarCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A0WC' )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Kodo4 takes nothing returns nothing\r\n    set gg_trg_Kodo4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Kodo4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Kodo4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Kodo4, Condition( function Trig_Kodo4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Kodo4, function Trig_Kodo4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}