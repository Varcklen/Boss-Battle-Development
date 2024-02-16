{
  "Id": 50333622,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Heuz4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'e008' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_Heuz4_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Undead\\\\DeathPact\\\\DeathPactTarget.mdl\", GetUnitX( udg_DamageEventTarget ), GetUnitY( udg_DamageEventTarget ) ) )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A05O')\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Heuz4 takes nothing returns nothing\r\n    set gg_trg_Heuz4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Heuz4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Heuz4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Heuz4, Condition( function Trig_Heuz4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Heuz4, function Trig_Heuz4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}