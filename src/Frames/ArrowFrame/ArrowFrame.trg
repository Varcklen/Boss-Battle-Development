{
  "Id": 50332290,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    framehandle arrowframe\r\nendglobals\r\n\r\nfunction ArrowFrame takes nothing returns nothing\r\n\t\tset arrowframe = BlzCreateFrameByType(\"BACKDROP\", \"\", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), \"StandartFrameTemplate\", 0)\r\n        call BlzFrameSetAbsPoint(arrowframe, FRAMEPOINT_CENTER, 0.4, 0.2)\t\r\n\t\tcall BlzFrameSetSize(arrowframe, 0.025, 0.025)\r\n        call BlzFrameSetTexture(arrowframe, \"FrameArrow.blp\", 0, true)\r\n\t\tcall BlzFrameSetVisible( arrowframe, false )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ArrowFrame takes nothing returns nothing\r\n    set gg_trg_ArrowFrame = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEvent( gg_trg_ArrowFrame, udg_StartTimer )\r\n    call TriggerAddAction( gg_trg_ArrowFrame, function ArrowFrame )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}