{
  "Id": 50332284,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    framehandle goldtext\r\n\tstring array goldstr \r\nendglobals\r\n\r\nfunction Trig_GoldBar_Actions takes nothing returns nothing\r\n    local framehandle icon\r\n    \r\n    set icon = BlzCreateFrameByType( \"BACKDROP\", \"\", BlzGetOriginFrame( ORIGIN_FRAME_GAME_UI, 0), \"StandardFrameTemplate\", 0)\r\n    call BlzFrameSetSize( icon, 0.016, 0.016 ) \r\n    call BlzFrameSetAbsPoint( icon, FRAMEPOINT_CENTER, 0.47, 0.589 ) \r\n    call BlzFrameSetTexture( icon, \"UI\\\\Feedback\\\\Resources\\\\ResourceGold.blp\", 0, true )\r\n\r\n    set goldtext = BlzCreateFrameByType( \"TEXT\", \"\", BlzGetOriginFrame( ORIGIN_FRAME_GAME_UI, 0), \"StandardFrameTemplate\", 0)\r\n    call BlzFrameSetSize( goldtext, 0.03, 0.03 ) \r\n    call BlzFrameSetAbsPoint( goldtext, FRAMEPOINT_CENTER, 0.543, 0.578 )\r\n    call BlzFrameSetText(goldtext, \"0\")\r\n    \r\n    set icon = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_GoldBar takes nothing returns nothing\r\n    set gg_trg_GoldBar = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEventBJ( gg_trg_GoldBar, udg_StartTimer )\r\n    call TriggerAddAction( gg_trg_GoldBar, function Trig_GoldBar_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}