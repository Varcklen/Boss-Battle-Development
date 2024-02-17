{
  "Id": 50333541,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Mehanic3_Conditions takes nothing returns boolean\r\n    return ( GetUnitTypeId( udg_DamageEventTarget ) == 'h010' ) and GetUnitLifePercent(udg_DamageEventTarget) <= 50\r\nendfunction\r\n\r\nfunction Trig_Mehanic3_Actions takes nothing returns nothing\r\n\tlocal integer cyclA = 1\r\n    local real x\r\n    local real y\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsmc\" ) ), bosscast(10), true, function MehanicCast )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        set x = GetUnitX(udg_DamageEventTarget) + 500 * Cos( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD)\r\n        set y = GetUnitY(udg_DamageEventTarget) + 500 * Sin( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD)\r\n        call CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'n012', x, y, 45 + ( 90 * cyclA ))\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Mehanic3 takes nothing returns nothing\r\n    set gg_trg_Mehanic3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Mehanic3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Mehanic3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Mehanic3, Condition( function Trig_Mehanic3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Mehanic3, function Trig_Mehanic3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}