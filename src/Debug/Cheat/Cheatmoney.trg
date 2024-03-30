{
  "Id": 50332353,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheatmoney_Actions takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    \r\n    if GetTriggerPlayer() == CheatSystem_GetCheater() then\r\n        loop\r\n            exitwhen cyclA > 3\r\n            if GetPlayerSlotState( Player( cyclA) ) == PLAYER_SLOT_STATE_PLAYING then\r\n                call moneyst( udg_hero[cyclA + 1], 1000 )\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        call BJDebugMsg( \"Received 1000 gold.\")\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheatmoney takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheatmoney = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n            call TriggerRegisterPlayerChatEvent( gg_trg_Cheatmoney, Player(cyclA), \"-money\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop \r\n    call TriggerAddAction( gg_trg_Cheatmoney, function Trig_Cheatmoney_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}