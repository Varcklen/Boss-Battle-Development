{
  "Id": 50333635,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Kodo1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventSource) == 'h01K' and not( IsUnitType( udg_DamageEventTarget, UNIT_TYPE_HERO) ) and not( IsUnitType( udg_DamageEventTarget, UNIT_TYPE_ANCIENT) ) and IsMinionImmune(udg_DamageEventTarget) == false\r\nendfunction\r\n\r\nfunction Trig_Kodo1_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Other\\\\Stampede\\\\StampedeMissileDeath.mdl\", GetUnitX( udg_DamageEventTarget ), GetUnitY( udg_DamageEventTarget ) ) )\r\n    call SetUnitState( udg_DamageEventSource, UNIT_STATE_LIFE, GetUnitState( udg_DamageEventSource, UNIT_STATE_LIFE) + GetUnitState( udg_DamageEventTarget, UNIT_STATE_MAX_LIFE) )\r\n    call KillUnit( udg_DamageEventTarget )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Kodo1 takes nothing returns nothing\r\n    set gg_trg_Kodo1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Kodo1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Kodo1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Kodo1, Condition( function Trig_Kodo1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Kodo1, function Trig_Kodo1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}