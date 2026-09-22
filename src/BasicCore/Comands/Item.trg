{
  "Id": 50332174,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Item_Conditions takes nothing returns boolean\r\n    return SubString(GetEventPlayerChatString(), 0, 5) == \"-item\" or SubString(GetEventPlayerChatString(), 0, 5) == \"-swap\" \r\nendfunction\r\n\r\nfunction Trig_Item_Actions takes nothing returns nothing\r\n\tcall DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 5, \"|cffff0000PROMPT.|r With the release of Warcraft III 3.0, all items can be freely moved around the inventory without using this command.\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Item takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Item = CreateTrigger()\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Item, Player(cyclA), \"-item \", false )\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Item, Player(cyclA), \"-swap \", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_Item, Condition( function Trig_Item_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Item, function Trig_Item_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}