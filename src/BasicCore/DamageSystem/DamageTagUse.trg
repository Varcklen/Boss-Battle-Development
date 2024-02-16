{
  "Id": 50332155,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_DamageTagUse_Actions takes nothing returns nothing\r\n     set udg_DamageEventAmount = GetEventDamage()\r\n     set udg_DamageEventTarget = BlzGetEventDamageTarget()\r\n     set udg_DamageEventSource = GetEventDamageSource()\r\n\r\n    set udg_DamageEventAfterArmor = 0.00\r\n\tset udg_DamageEventAfterArmor = 1.00\r\n\tset udg_DamageEventAfterArmor = 0.00\r\n\r\n    call BlzSetEventDamage( udg_DamageEventAmount )\r\n\r\n\tset udg_DamageEvent = 0.00\r\n\tset udg_DamageEvent = 1.00\r\n\tset udg_DamageEvent = 0.00\r\n    \r\n    set IsAttack = false\r\n\r\n\tset udg_DamageEventAmount = 0\r\n\tset udg_DamageEventTarget = null\r\n\tset udg_DamageEventSource = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DamageTagUse takes nothing returns nothing\r\n    set gg_trg_DamageTagUse = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_DamageTagUse, EVENT_PLAYER_UNIT_DAMAGED )\r\n    //call TriggerRegisterAnyUnitEventBJ( gg_trg_DamageTagUse, EVENT_PLAYER_UNIT_DAMAGING )\r\n    call TriggerAddAction( gg_trg_DamageTagUse, function Trig_DamageTagUse_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}