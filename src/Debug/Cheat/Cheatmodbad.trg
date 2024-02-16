{
  "Id": 50332350,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheatmodbad_Conditions takes nothing returns boolean\r\n    return SubString(GetEventPlayerChatString(), 0, 7) == \"-modbad\"\r\nendfunction\r\n\r\nfunction Trig_Cheatmodbad_Actions takes nothing returns nothing\r\n    local integer i = S2I(SubString(GetEventPlayerChatString(), 8, 10))\r\n    local integer p\r\n    \r\n\tif i > 0 and i <= udg_Database_NumberItems[22] then\r\n\t\tif udg_modbad[i] then\r\n\t\t    set udg_modbad[i] = false\r\n\t\t    call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5.00, \"Бонус (BAD) |cffffcc00№\" + I2S(i) + \"|r выключен.\" )\r\n            call IconFrameDel( \"ModBad\" + I2S(i) )\r\n\t\telse\r\n\t\t    set udg_modbad[i] = true\r\n\t\t    call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5.00, \"Бонус (BAD) |cffffcc00№\" + I2S(i) + \"|r активирован.\" )\r\n            set p = udg_DB_BadMod[i]\r\n            call IconFrame( \"ModBad\" + I2S(i), BlzGetAbilityIcon(p), BlzGetAbilityTooltip(p, 0), BlzGetAbilityExtendedTooltip(p, 0) )\r\n\t\tendif\r\n\tendif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheatmodbad takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheatmodbad = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Cheatmodbad )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Cheatmodbad, Player(cyclA), \"-modbad \", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_Cheatmodbad, Condition( function Trig_Cheatmodbad_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Cheatmodbad, function Trig_Cheatmodbad_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}