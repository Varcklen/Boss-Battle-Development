{
  "Id": 50333342,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_CircusPA_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel(udg_DamageEventSource, 'A0S7') > 0 and luckylogic( udg_DamageEventSource, 10 + ( 5 * GetUnitAbilityLevel(udg_DamageEventSource, 'A0S7') ), 1, 100 ) and not( udg_IsDamageSpell )\r\nendfunction\r\n\r\nfunction Trig_CircusPA_Actions takes nothing returns nothing\r\n    local unit u = randomtarget( udg_DamageEventSource, 900, \"enemy\", \"\", \"\", \"\", \"\" )\r\n    \r\n    if u != null then\r\n        call DemomanCurse( udg_DamageEventSource, u )\r\n    endif\r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_CircusPA takes nothing returns nothing\r\n    set gg_trg_CircusPA = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_CircusPA, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_CircusPA, Condition( function Trig_CircusPA_Conditions ) )\r\n    call TriggerAddAction( gg_trg_CircusPA, function Trig_CircusPA_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}