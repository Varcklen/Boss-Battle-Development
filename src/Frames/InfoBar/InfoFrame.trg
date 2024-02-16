{
  "Id": 50332294,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n     \tframehandle array infrtlp\r\nendglobals\r\n\r\nfunction Trig_InfoFrame_Actions takes nothing returns nothing\r\n\tlocal framehandle faceHover\r\n\tlocal integer cyclA\r\n\tlocal integer cyclAEnd \r\n\r\n    set cyclA = 1\r\n    set cyclAEnd = udg_DB_InfoFrame_Number\r\n\tloop\r\n\t\texitwhen cyclA > cyclAEnd\r\n\t\tset faceHover = BlzCreateFrameByType(\"FRAME\", \"\", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0),\"\", 0)\r\n        call BlzFrameSetSize(faceHover, 0.08, 0.02)\r\n        call BlzFrameSetAbsPoint(faceHover, FRAMEPOINT_LEFT, 0.375+(cyclA*0.088), 0.588)\r\n        \r\n        call SetStableTool( faceHover, udg_DB_InfoFrame_Name[cyclA], udg_DB_InfoFrame_Tooltip[cyclA] )\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\n\r\n\tset faceHover = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_InfoFrame takes nothing returns nothing\r\n    set gg_trg_InfoFrame = CreateTrigger(  )\r\n    call TriggerRegisterTimerEventSingle( gg_trg_InfoFrame, 0.10 )\r\n    call TriggerAddAction( gg_trg_InfoFrame, function Trig_InfoFrame_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}