{
  "Id": 50332176,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Load_Conditions takes nothing returns boolean\r\n    return SubString(GetEventPlayerChatString(), 0, 5) == \"-load\" and not( udg_logic[43] ) and not(udg_logic[1])\r\nendfunction\r\n\r\nfunction Trig_Load_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetTriggerPlayer()) + 1\r\n\r\n    if (GetEventPlayerChatString() == \"-load\") then\r\n        call Trig_Autoload_Actions()\r\n    else\r\n        call LoadProgress( i, GetEventPlayerChatString() )\r\n        call BonusLoad(i)\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Load takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Load = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Load, Player(cyclA), \"-load\", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_Load, Condition( function Trig_Load_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Load, function Trig_Load_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}