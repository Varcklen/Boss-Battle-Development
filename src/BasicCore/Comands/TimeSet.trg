{
  "Id": 50332173,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_TimeSet_Conditions takes nothing returns boolean\r\n    local integer time = S2I(SubString(GetEventPlayerChatString(), 6, 10))\r\n    return GetTriggerPlayer() == udg_Host and SubString(GetEventPlayerChatString(), 0, 5) == \"-time\" and ((time >= 60 and time <= 300) or time == 0 ) \r\nendfunction\r\n\r\nfunction Trig_TimeSet_Actions takes nothing returns nothing\r\n\tset udg_real[1] = S2I(SubString(GetEventPlayerChatString(), 6, 10))\r\n\r\n    call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 10, \"|cffffcc00Out-of-combat timer set:|r \" + I2S( R2I(udg_real[1]) ) + \" seconds.\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_TimeSet takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_TimeSet = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_TimeSet, Player(cyclA), \"-time \", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_TimeSet, Condition( function Trig_TimeSet_Conditions ) )\r\n    call TriggerAddAction( gg_trg_TimeSet, function Trig_TimeSet_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}