{
  "Id": 50332358,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheatheroes_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n\r\n    if GetTriggerPlayer() == CheatSystem_GetCheater() then\r\n        call DisplayTimedTextToForce( GetForceOfPlayer(GetTriggerPlayer()), 10., ( \"Количество игроков: \" + I2S(udg_Heroes_Amount) ) )\r\n        loop\r\n            exitwhen cyclA > 4\r\n            call DisplayTimedTextToForce( GetForceOfPlayer(GetTriggerPlayer()), 10., GetUnitName(udg_hero[cyclA]) )\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheatheroes takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheatheroes = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Cheatheroes )\r\n    loop\r\n        exitwhen cyclA > 3\r\n            call TriggerRegisterPlayerChatEvent( gg_trg_Cheatheroes, Player(cyclA), \"-heroes\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Cheatheroes, function Trig_Cheatheroes_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}