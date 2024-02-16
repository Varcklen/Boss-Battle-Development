{
  "Id": 50332349,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheatmodgood_Conditions takes nothing returns boolean\r\n    return SubString(GetEventPlayerChatString(), 0, 8) == \"-modgood\"\r\nendfunction\r\n\r\nfunction Trig_Cheatmodgood_Actions takes nothing returns nothing\r\n    local integer i = S2I(SubString(GetEventPlayerChatString(), 9, 11))\r\n    local integer p\r\n    \r\n\tif i > 0 and i <= udg_Database_NumberItems[7] then\r\n\t\tif udg_modgood[i] then\r\n\t\t    set udg_modgood[i] = false\r\n\t\t    call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5.00, \"Бонус (GOOD) |cffffcc00№\" + I2S(i) + \"|r выключен.\" )\r\n            call IconFrameDel( \"ModGood\" + I2S(i) )\r\n\t\telse\r\n\t\t    set udg_modgood[i] = true\r\n\t\t    call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5.00, \"Бонус (GOOD) |cffffcc00№\" + I2S(i) + \"|r активирован.\" )\r\n            set p = udg_DB_GoodMod[i]\r\n            call IconFrame( \"ModGood\" + I2S(i), BlzGetAbilityIcon(p), BlzGetAbilityTooltip(p, 0), BlzGetAbilityExtendedTooltip(p, 0) )\r\n\t\tendif\r\n\tendif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheatmodgood takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheatmodgood = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Cheatmodgood )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Cheatmodgood, Player(cyclA), \"-modgood \", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_Cheatmodgood, Condition( function Trig_Cheatmodgood_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Cheatmodgood, function Trig_Cheatmodgood_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}