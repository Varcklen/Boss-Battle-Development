{
  "Id": 50333582,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MountGiant3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'e000' and GetUnitLifePercent(udg_DamageEventTarget) <= 70\r\nendfunction\r\n\r\nfunction Trig_MountGiant3_Actions takes nothing returns nothing\r\n    local unit u = GroupPickRandomUnit(udg_otryad)\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n\tif u != null then\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\ThunderClap\\\\ThunderClapCaster.mdl\", GetUnitX(u), GetUnitY(u) ) ) \r\n        call UnitStun(udg_DamageEventTarget, u, 10 )\r\n\tendif\r\n    \r\n\tset u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MountGiant3 takes nothing returns nothing\r\n    set gg_trg_MountGiant3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_MountGiant3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_MountGiant3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_MountGiant3, Condition( function Trig_MountGiant3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MountGiant3, function Trig_MountGiant3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}