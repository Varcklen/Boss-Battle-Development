{
  "Id": 50332321,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    framehandle gqfone\r\n    framehandle gqicon\r\n    framehandle gqname\r\nendglobals\r\n\r\nfunction Trig_GuildQuestFrame_Actions takes nothing returns nothing\r\n    set gqfone = BlzCreateFrame(\"QuestButtonBaseTemplate\", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)\r\n    call BlzFrameSetSize(gqfone, 0.1,0.035)\r\n\tcall BlzFrameSetAbsPoint(gqfone, FRAMEPOINT_CENTER, 0.54, 0.156)\r\n    call BlzFrameSetVisible( gqfone, false )\r\n    \r\n\tset gqicon = BlzCreateFrameByType(\"BACKDROP\", \"\", gqfone, \"\", 0)\r\n    call BlzFrameSetPoint(gqicon, FRAMEPOINT_TOPLEFT, gqfone, FRAMEPOINT_TOPLEFT, 0.01, -0.01) \t\r\n\tcall BlzFrameSetSize(gqicon, 0.018, 0.018)\r\n    \r\n    set gqname = BlzCreateFrameByType(\"TEXT\", \"\", gqfone, \"StandartFrameTemplate\", 0)\r\n\tcall BlzFrameSetSize( gqname, 0.06, 0.02 )\r\n\tcall BlzFrameSetPoint(gqname, FRAMEPOINT_CENTER, gqfone, FRAMEPOINT_CENTER, 0.02,-0.005) \r\n\tcall BlzFrameSetText( gqname, \"0/1000\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_GuildQuestFrame takes nothing returns nothing\r\n    set gg_trg_GuildQuestFrame = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEventBJ( gg_trg_GuildQuestFrame, udg_StartTimer )\r\n    call TriggerAddAction( gg_trg_GuildQuestFrame, function Trig_GuildQuestFrame_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}