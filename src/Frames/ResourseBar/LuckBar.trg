{
  "Id": 50332287,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    framehandle lucktext\r\nendglobals\r\n\r\nfunction Trig_LuckBar_Actions takes nothing returns nothing\r\n    local framehandle icon\r\n    \r\n    set icon = BlzCreateFrameByType( \"BACKDROP\", \"\", BlzGetOriginFrame( ORIGIN_FRAME_GAME_UI, 0), \"StandardFrameTemplate\", 0)\r\n    call BlzFrameSetSize( icon, 0.016, 0.016 ) \r\n    call BlzFrameSetAbsPoint( icon, FRAMEPOINT_CENTER, 0.644, 0.589 ) \r\n    call BlzFrameSetTexture( icon, \"ReplaceableTextures\\\\PassiveButtons\\\\PASBTNPillage.blp\", 0, true )\r\n\r\n    set lucktext = BlzCreateFrameByType( \"TEXT\", \"\", BlzGetOriginFrame( ORIGIN_FRAME_GAME_UI, 0), \"StandardFrameTemplate\", 0)\r\n    call BlzFrameSetSize( lucktext, 0.03, 0.03 ) \r\n    call BlzFrameSetAbsPoint( lucktext, FRAMEPOINT_CENTER, 0.711, 0.578 )\r\n    call BlzFrameSetText(lucktext, \"0%\")\r\n    \r\n    set icon = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_LuckBar takes nothing returns nothing\r\n    set gg_trg_LuckBar = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEventBJ( gg_trg_LuckBar, udg_StartTimer )\r\n    call TriggerAddAction( gg_trg_LuckBar, function Trig_LuckBar_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}