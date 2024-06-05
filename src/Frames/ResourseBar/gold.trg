{
  "Id": 50332285,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_gold_Actions takes nothing returns nothing\r\n\tlocal string text = I2S( GetPlayerState( GetTriggerPlayer(), PLAYER_STATE_RESOURCE_GOLD) )\r\n\t//local real i\r\n\t//local integer k = GetConvertedPlayerId(GetTriggerPlayer())\r\n\tif GetLocalPlayer() == GetTriggerPlayer() then\r\n\t\t//set i = StringLength(goldstr[k]) * 0.004\r\n\t\tcall BlzFrameSetText(goldtext, text)\r\n\t\t//call BlzFrameSetAbsPoint( goldtext, FRAMEPOINT_CENTER, 0.547 - i, 0.578 )\r\n\tendif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_gold takes nothing returns nothing\r\n    set gg_trg_gold = CreateTrigger(  )\r\n    call TriggerRegisterPlayerStateEvent( gg_trg_gold, Player(0), PLAYER_STATE_RESOURCE_GOLD, NOT_EQUAL, 0.01 )\r\n\tcall TriggerRegisterPlayerStateEvent( gg_trg_gold, Player(1), PLAYER_STATE_RESOURCE_GOLD, NOT_EQUAL, 0.01 )\r\n\tcall TriggerRegisterPlayerStateEvent( gg_trg_gold, Player(2), PLAYER_STATE_RESOURCE_GOLD, NOT_EQUAL, 0.01 )\r\n\tcall TriggerRegisterPlayerStateEvent( gg_trg_gold, Player(3), PLAYER_STATE_RESOURCE_GOLD, NOT_EQUAL, 0.01 )\r\n    call TriggerAddAction( gg_trg_gold, function Trig_gold_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}