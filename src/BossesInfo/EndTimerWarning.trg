{
  "Id": 50333399,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_EndTimerWarning_Actions takes nothing returns nothing\r\n    call DisplayTimedTextToForce( GetPlayersAll(), 10, \"|cffffcc00Warning!|r 20 seconds left before the battle starts!\" )\r\n    call StartSound(gg_snd_Warning)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_EndTimerWarning takes nothing returns nothing\r\n    set gg_trg_EndTimerWarning = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEvent( gg_trg_EndTimerWarning, udg_timer[2] )\r\n    call TriggerAddAction( gg_trg_EndTimerWarning, function Trig_EndTimerWarning_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}