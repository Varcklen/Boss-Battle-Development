{
  "Id": 50333620,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Heuz2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'e008' and GetUnitLifePercent(udg_DamageEventTarget) <= 85\r\nendfunction\r\n\r\nfunction Trig_Heuz2_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A05K')\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Undead\\\\DeathPact\\\\DeathPactTarget.mdl\", GetUnitX( udg_DamageEventTarget ), GetUnitY( udg_DamageEventTarget ) ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Heuz2 takes nothing returns nothing\r\n    set gg_trg_Heuz2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Heuz2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Heuz2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Heuz2, Condition( function Trig_Heuz2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Heuz2, function Trig_Heuz2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}