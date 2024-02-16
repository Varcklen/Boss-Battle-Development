{
  "Id": 50333326,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    framehandle entQText\r\n    framehandle entQBackdrop\r\nendglobals\r\n\r\nfunction Trig_Corrupted_EntQFrame_Actions takes nothing returns nothing\r\n    set entQBackdrop = BlzCreateFrameByType(\"BACKDROP\", \"\", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), \"StandartFrameTemplate\", 0)\r\n    call BlzFrameSetSize( entQBackdrop, 0.012, 0.012 )\r\n    call BlzFrameSetAbsPoint(entQBackdrop, FRAMEPOINT_CENTER, 0.65, 0.017)\r\n    call BlzFrameSetTexture( entQBackdrop, \"war3mapImported\\\\BTNfeed-icon-red-1_result.blp\",0, true)\r\n    call BlzFrameSetVisible( entQBackdrop, false )\r\n\r\n    set entQText = BlzCreateFrameByType(\"TEXT\", \"\", entQBackdrop, \"StandartFrameTemplate\", 0)\r\n    call BlzFrameSetSize( entQText, 0.005, 0.01 )\r\n    call BlzFrameSetAbsPoint(entQText, FRAMEPOINT_CENTER, 0.651, 0.017)\r\n    call BlzFrameSetText( entQText, \"0\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Corrupted_EntQFrame takes nothing returns nothing\r\n    set gg_trg_Corrupted_EntQFrame = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEvent( gg_trg_Corrupted_EntQFrame, udg_StartTimer )\r\n    call TriggerAddAction( gg_trg_Corrupted_EntQFrame, function Trig_Corrupted_EntQFrame_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}