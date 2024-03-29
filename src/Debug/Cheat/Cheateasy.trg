{
  "Id": 50332354,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheateasy_Actions takes nothing returns nothing\r\n    if GetTriggerPlayer() == CheatSystem_GetCheater() then\r\n        set udg_Heroes_Chanse = udg_Heroes_Chanse + 5\r\n        call MultiSetValue( udg_multi, 2, 1, I2S(udg_Heroes_Chanse) )\r\n        call BJDebugMsg(\"Added 5 attempts.\")\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheateasy takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheateasy = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n            call TriggerRegisterPlayerChatEvent( gg_trg_Cheateasy, Player(cyclA), \"-easy\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Cheateasy, function Trig_Cheateasy_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}