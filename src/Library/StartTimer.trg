{
  "Id": 50332110,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_StartTimer_Actions takes nothing returns nothing\r\n    call BlzChangeMinimapTerrainTex(\"map.blp\")\r\n    //call DisplayCineFilterBJ( false )\r\n    call StartTimerBJ( udg_StartTimer, false, 0.01 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_StartTimer takes nothing returns nothing\r\n    set gg_trg_StartTimer = CreateTrigger(  )\r\n    call TriggerAddAction( gg_trg_StartTimer, function Trig_StartTimer_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}