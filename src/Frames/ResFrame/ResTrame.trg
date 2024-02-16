{
  "Id": 50332315,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    framehandle resback\r\n    framehandle restext\r\nendglobals\r\n\r\nfunction ResTrame takes nothing returns nothing\r\n    local framehandle frame\r\n    local real x = 1.2\r\n    local real y = 1.2\r\n    \r\n    set resback = BlzCreateFrameByType(\"BACKDROP\", \"\", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), \"StandartFrameTemplate\", 0)\r\n    call BlzFrameSetAbsPoint(resback, FRAMEPOINT_CENTER, 0.35, 0.565)\t\r\n    call BlzFrameSetSize(resback, 0.02*x, 0.012*y)\r\n    call BlzFrameSetTexture( resback, \"war3mapImported\\\\BTNfeed-icon-red-1_result.blp\",0, true)\r\n    call BlzFrameSetVisible( resback, false )\r\n    \r\n    set frame = BlzCreateFrameByType(\"BACKDROP\", \"\", resback, \"StandartFrameTemplate\", 0)\r\n    call BlzFrameSetPoint( frame, FRAMEPOINT_CENTER, resback, FRAMEPOINT_CENTER, -0.005*x, 0*y )\r\n    call BlzFrameSetSize(frame, 0.01*x, 0.01*y)\r\n    call BlzFrameSetTexture( frame, \"ReplaceableTextures\\\\CommandButtons\\\\BTNAnkh.blp\",0, true)\r\n        \r\n    set restext = BlzCreateFrameByType(\"TEXT\", \"\", resback, \"StandartFrameTemplate\", 0)\r\n    call BlzFrameSetSize( restext, 0.01*x, 0.01*y )\r\n    call BlzFrameSetPoint(restext, FRAMEPOINT_BOTTOMLEFT, resback, FRAMEPOINT_BOTTOMLEFT, 0.012*x,0*y) \r\n    call BlzFrameSetText( restext, \"0\" )\r\n    \r\n    set frame = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ResTrame takes nothing returns nothing\r\n    set gg_trg_ResTrame = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEvent( gg_trg_ResTrame, udg_StartTimer )\r\n    call TriggerAddAction( gg_trg_ResTrame, function ResTrame )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}