{
  "Id": 50333458,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Fedor1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h00B' and GetUnitLifePercent(udg_DamageEventTarget) <= 66\r\nendfunction\r\n\r\nfunction Trig_Fedor1_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local real x\r\n    local real y\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        set x = GetUnitX(udg_DamageEventTarget) + 1200 * Cos((45 + ( 90 * cyclA )) * bj_DEGTORAD)\r\n        set y = GetUnitY(udg_DamageEventTarget) + 1200 * Sin((45 + ( 90 * cyclA )) * bj_DEGTORAD)\r\n        set bj_lastCreatedUnit = CreateUnit(GetOwningPlayer( udg_DamageEventTarget ), 'o008', x, y, 45 + ( 90 * cyclA ) )\r\n        call PingMinimapLocForForceEx( bj_FORCE_ALL_PLAYERS, GetUnitLoc( bj_lastCreatedUnit ), 5, bj_MINIMAPPINGSTYLE_ATTACK, 100, 50, 50 )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Fedor1 takes nothing returns nothing\r\n    set gg_trg_Fedor1 = CreateTrigger()\r\n    call DisableTrigger( gg_trg_Fedor1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Fedor1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Fedor1, Condition( function Trig_Fedor1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Fedor1, function Trig_Fedor1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}