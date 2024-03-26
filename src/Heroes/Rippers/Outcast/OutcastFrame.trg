{
  "Id": 50332327,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n     \tframehandle outcastframe\r\n     \tframehandle array outballframe\r\nendglobals\r\n\r\nfunction OutcastFrame takes nothing returns nothing\r\n\tlocal integer cyclA = 1\r\n\r\n    set outcastframe = BlzCreateFrameByType(\"BACKDROP\", \"\", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), \"StandartFrameTemplate\", 0)\r\n    call BlzFrameSetAbsPoint(outcastframe, FRAMEPOINT_LEFT, 0, 0.19)\t\r\n    call BlzFrameSetSize(outcastframe, 0.24, 0.12)\r\n    call BlzFrameSetTexture(outcastframe, \"outcastframe.blp\", 0, true)\r\n    call BlzFrameSetLevel( outcastframe, -1 )\r\n    call BlzFrameSetVisible( outcastframe, false )\r\n\r\n\tloop\r\n\t\texitwhen cyclA > 3\r\n\t\tset outballframe[cyclA] = BlzCreateFrameByType(\"BACKDROP\", \"\", outcastframe, \"StandartFrameTemplate\", 0)\r\n    \t\tcall BlzFrameSetAbsPoint(outballframe[cyclA], FRAMEPOINT_CENTER, (0.06*cyclA)-0.008, 0.20)\t\r\n\t\tcall BlzFrameSetSize(outballframe[cyclA], 0.07, 0.07)\r\n    \t\tcall BlzFrameSetVisible( outballframe[cyclA], false )\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\n\r\n    call BlzFrameSetTexture(outballframe[1], \"ballred.blp\", 0, true)\r\n    call BlzFrameSetTexture(outballframe[2], \"ballgreen.blp\", 0, true)\r\n    call BlzFrameSetTexture(outballframe[3], \"ballblue.blp\", 0, true)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_OutcastFrame takes nothing returns nothing\r\n    set gg_trg_OutcastFrame = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEvent( gg_trg_OutcastFrame, udg_StartTimer )\r\n    call TriggerAddAction( gg_trg_OutcastFrame, function OutcastFrame )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}