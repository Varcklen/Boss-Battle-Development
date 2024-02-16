{
  "Id": 50332374,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Bers1_Actions takes nothing returns nothing\r\n    call berserk( udg_hero[2], 1 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Bers1 takes nothing returns nothing\r\n    set gg_trg_Bers1 = CreateTrigger(  )\r\n    call TriggerRegisterPlayerChatEvent( gg_trg_Bers1, Player(0), \"2\", true )\r\n    call TriggerAddAction( gg_trg_Bers1, function Trig_Bers1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}