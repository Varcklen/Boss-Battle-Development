{
  "Id": 50332995,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_NerubP_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel( udg_DamageEventTarget, 'A0D6') > 0 and IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) and luckylogic( udg_DamageEventTarget, 15, 1, 100 ) and not( udg_fightmod[3] )\r\nendfunction\r\n    \r\nfunction Trig_NerubP_Actions takes nothing returns nothing\r\n\tlocal integer i = GetUnitAbilityLevel( udg_DamageEventTarget, 'A0D6')\r\n    call BlzSetUnitMaxHP( udg_DamageEventTarget, ( BlzGetUnitMaxHP(udg_DamageEventTarget) + i ) )\r\n    set udg_Data[GetPlayerId(GetOwningPlayer(udg_DamageEventTarget)) + 1 + 100] = udg_Data[GetPlayerId(GetOwningPlayer(udg_DamageEventTarget)) + 1 + 100] + i\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_NerubP takes nothing returns nothing\r\n    set gg_trg_NerubP = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_NerubP, \"udg_DamageModifierEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_NerubP, Condition( function Trig_NerubP_Conditions ) )\r\n    call TriggerAddAction( gg_trg_NerubP, function Trig_NerubP_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}