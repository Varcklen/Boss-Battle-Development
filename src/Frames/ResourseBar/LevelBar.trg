{
  "Id": 50332288,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n\tframehandle lvltext\r\nendglobals\r\n\r\nfunction Trig_LevelBar_Actions takes nothing returns nothing\r\n    set lvltext = BlzCreateFrameByType( \"TEXT\", \"\", BlzGetOriginFrame( ORIGIN_FRAME_GAME_UI, 0), \"StandardFrameTemplate\", 0)\r\n    call BlzFrameSetSize( lvltext, 0.03, 0.016 ) \r\n    call BlzFrameSetAbsPoint( lvltext, FRAMEPOINT_CENTER, 0.76, 0.584 )\r\n    call BlzFrameSetText(lvltext, \"1/10\")\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_LevelBar takes nothing returns nothing\r\n    set gg_trg_LevelBar = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEventBJ( gg_trg_LevelBar, udg_StartTimer )\r\n    call TriggerAddAction( gg_trg_LevelBar, function Trig_LevelBar_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}