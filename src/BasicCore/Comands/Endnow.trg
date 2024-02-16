{
  "Id": 50332178,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Endnow_Conditions takes nothing returns boolean\r\n    return (udg_fightmod[2] or udg_fightmod[4]) and GetTriggerPlayer() == udg_Host\r\nendfunction\r\n\r\nfunction Trig_Endnow_Actions takes nothing returns nothing\r\n    if udg_fightmod[2] then\r\n            call Between( \"end_IA\" )\r\n    elseif udg_fightmod[4] then\r\n        call Between( \"end_AL\" )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Endnow takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Endnow = CreateTrigger()\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Endnow, Player(cyclA), \"-endnow\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_Endnow, Condition( function Trig_Endnow_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Endnow, function Trig_Endnow_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}