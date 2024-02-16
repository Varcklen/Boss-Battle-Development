{
  "Id": 50333412,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Morloc3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n005' and GetUnitLifePercent(udg_DamageEventTarget) <= 25.\r\nendfunction\r\n\r\nfunction Trig_Morloc3_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call SetUnitAnimation( udg_DamageEventTarget, \"spell\" )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        call CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'n006', GetUnitX( udg_DamageEventTarget ) + GetRandomReal( -200, 200 ), GetUnitY( udg_DamageEventTarget ) + GetRandomReal( -200, 200 ), GetRandomReal( 0, 360 ) )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Morloc3 takes nothing returns nothing\r\n    set gg_trg_Morloc3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Morloc3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Morloc3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Morloc3, Condition( function Trig_Morloc3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Morloc3, function Trig_Morloc3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}