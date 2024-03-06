{
  "Id": 50332146,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_LoadModule_Actions takes nothing returns nothing\r\n\tif GetPlayerName(Player(0)) == \"WorldEdit\" then\r\n\t\tcall Preloader(\"WorldEditorProgress\\\\Boss Battle Progress.txt\")\r\n\telse\r\n    \tcall Preloader(\"BossBattleSave\\\\Boss Battle Progress.txt\")\r\n\tendif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_LoadModule takes nothing returns nothing\r\n    set gg_trg_LoadModule = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEvent( gg_trg_LoadModule, udg_StartTimer )\r\n    call TriggerAddAction( gg_trg_LoadModule, function Trig_LoadModule_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}