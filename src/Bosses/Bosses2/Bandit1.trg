{
  "Id": 50333443,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Bandit1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h014'\r\nendfunction\r\n\r\nfunction Trig_Bandit1_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call SaveInteger( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsrg\" ), 1 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Bandit1 takes nothing returns nothing\r\n    set gg_trg_Bandit1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Bandit1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Bandit1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Bandit1, Condition( function Trig_Bandit1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Bandit1, function Trig_Bandit1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}