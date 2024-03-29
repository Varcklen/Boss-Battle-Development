{
  "Id": 50332349,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheatmodgood_Conditions takes nothing returns boolean\r\n    return SubString(GetEventPlayerChatString(), 0, 6) == \"-bless\"\r\nendfunction\r\n\r\nfunction Trig_Cheatmodgood_Actions takes nothing returns nothing\r\n    local integer i = S2I(SubString(GetEventPlayerChatString(), 7, 9))\r\n    local Mode mode\r\n    \r\n    if i < 0 or i >= ModeClass_InactiveBlesses.Size then\r\n    \tcall BJDebugMsg(\"i out of range: \" + I2S(i) + \" [0-\" + I2S(ModeClass_InactiveBlesses.Size-1) + \"].\" )\r\n    \treturn\r\n    endif\r\n    \r\n    set mode = ModeClass_InactiveBlesses.GetIntegerByIndex(i)\r\n\t\r\n\tcall ModeSystem_Enable(mode)\r\n\tcall DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5.00, \"Bless \" + BlzGetAbilityTooltip(mode.Info, 0) + \"|r enabled.\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheatmodgood takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheatmodgood = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Cheatmodgood, Player(cyclA), \"-bless \", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_Cheatmodgood, Condition( function Trig_Cheatmodgood_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Cheatmodgood, function Trig_Cheatmodgood_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}