{
  "Id": 50332303,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": true,
  "Script": "function Trig_BonusFrameInit_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd = udg_DB_BonusFrame_Number\r\n\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call CreateIcon(cyclA)\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_BonusFrameInit takes nothing returns nothing\r\n    set gg_trg_BonusFrameInit = CreateTrigger(  )\r\n    call TriggerAddAction( gg_trg_BonusFrameInit, function Trig_BonusFrameInit_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}