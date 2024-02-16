{
  "Id": 50333171,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Refresh_Actions takes nothing returns nothing\r\n    call BJDebugMsg(\"Special shop refreshed.\")\r\n    call SpecialsShop_Refresh()\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Refresh takes nothing returns nothing\r\n    set gg_trg_Refresh = CreateTrigger()\r\n    call DisableTrigger( gg_trg_Refresh )\r\n    call TriggerRegisterPlayerChatEvent( gg_trg_Refresh, Player(0), \"-ref\", false )\r\n    call TriggerAddAction( gg_trg_Refresh, function Trig_Refresh_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}