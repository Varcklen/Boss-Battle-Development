{
  "Id": 50332358,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheatheroes_Actions takes nothing returns nothing\r\n    local integer i = 1\r\n\r\n    call BJDebugMsg( \"Hero Amount: \" + I2S(udg_Heroes_Amount) )\r\n    loop\r\n        exitwhen i > 4\r\n        call BJDebugMsg( \"Hero Name [\"+ I2S(i) +\"]:\" + GetUnitName(udg_hero[i]) )\r\n        set i = i + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheatheroes takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheatheroes = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Cheatheroes )\r\n    loop\r\n        exitwhen cyclA > 3\r\n            call TriggerRegisterPlayerChatEvent( gg_trg_Cheatheroes, Player(cyclA), \"-heroes\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Cheatheroes, function Trig_Cheatheroes_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}