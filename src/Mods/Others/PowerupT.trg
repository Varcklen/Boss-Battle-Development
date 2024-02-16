{
  "Id": 50332242,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PowerupT_Actions takes nothing returns nothing\r\n        call DisplayTimedTextToForce( GetPlayersAll(), 5.00, \"Enemies have become stronger +5\" + udg_perc + \"!\" )\r\n    \tset udg_BossHP = udg_BossHP + 0.05\r\n    \tset udg_BossAT = udg_BossAT + 0.05\r\n        call SpellPower_AddBossSpellPower(0.05)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PowerupT takes nothing returns nothing\r\n    set gg_trg_PowerupT = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEvent( gg_trg_PowerupT, udg_timer[4] )\r\n    call TriggerAddAction( gg_trg_PowerupT, function Trig_PowerupT_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}