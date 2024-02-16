{
  "Id": 50332325,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n     \tframehandle shamanframe\r\n     \tframehandle array spfframe\r\nendglobals\r\n\r\nfunction ShamanFrame takes nothing returns nothing\r\n\tlocal integer cyclA = 1\r\n\r\n\t\tset shamanframe = BlzCreateFrameByType(\"BACKDROP\", \"\", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), \"StandartFrameTemplate\", 0)\r\n    \t\tcall BlzFrameSetAbsPoint(shamanframe, FRAMEPOINT_LEFT, 0, 0.19)\t\r\n\t\tcall BlzFrameSetSize(shamanframe, 0.24, 0.12)\r\n    \t\tcall BlzFrameSetTexture(shamanframe, \"frame light.blp\", 0, true)\r\n\t\tcall BlzFrameSetLevel( shamanframe, -1 )\r\n    \t\tcall BlzFrameSetVisible( shamanframe, false )\r\n\r\n\tloop\r\n\t\texitwhen cyclA > 3\r\n\t\tset spfframe[cyclA] = BlzCreateFrameByType(\"BACKDROP\", \"\", shamanframe, \"StandartFrameTemplate\", 0)\r\n    \t\tcall BlzFrameSetAbsPoint(spfframe[cyclA], FRAMEPOINT_CENTER, (0.065*cyclA)-0.02, 0.20)\t\r\n            call BlzFrameSetSize(spfframe[cyclA], 0.1, 0.1)\r\n    \t\tcall BlzFrameSetTexture(spfframe[cyclA], \"framesphere.blp\", 0, true)\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ShamanFrame takes nothing returns nothing\r\n    set gg_trg_ShamanFrame = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEvent( gg_trg_ShamanFrame, udg_StartTimer )\r\n    call TriggerAddAction( gg_trg_ShamanFrame, function ShamanFrame )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}