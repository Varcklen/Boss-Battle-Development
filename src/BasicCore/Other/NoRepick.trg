{
  "Id": 50332195,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_NoRepick_Actions takes nothing returns nothing\r\n    set udg_logic[9] = true\r\n    call BlzFrameSetVisible( rpkmod,false)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_NoRepick takes nothing returns nothing\r\n    set gg_trg_NoRepick = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEvent( gg_trg_NoRepick, udg_timer[3] )\r\n    call TriggerAddAction( gg_trg_NoRepick, function Trig_NoRepick_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}