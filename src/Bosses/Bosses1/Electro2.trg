{
  "Id": 50333419,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Electro2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'n00Z' and GetUnitLifePercent( udg_DamageEventTarget ) <= 50\r\nendfunction\r\n\r\nfunction Trig_Electro2_Actions takes nothing returns nothing\r\n    local integer i = 1\r\n    local real x\r\n    local real y\r\n    local real unitX = GetUnitX(udg_DamageEventTarget)\r\n    local real unitY = GetUnitY(udg_DamageEventTarget)\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    loop\r\n        exitwhen i > 8\r\n        set x = unitX + 400 * Cos(45. * i * bj_DEGTORAD)\r\n        set y = unitY + 400 * Sin(45. * i * bj_DEGTORAD)\r\n        call Electro_CreateField( udg_DamageEventTarget, x, y, 20 )\r\n        set i = i + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Electro2 takes nothing returns nothing\r\n    set gg_trg_Electro2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Electro2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Electro2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Electro2, Condition( function Trig_Electro2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Electro2, function Trig_Electro2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}