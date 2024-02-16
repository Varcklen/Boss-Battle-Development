{
  "Id": 50332136,
  "Comment": "Eldrich Moon\r\n\r\nby zihell",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Freedom_of_Choice_Actions takes nothing returns nothing\r\n    set udg_Database_NumberItems[2] = 1\r\n    set DB_Items[2][1] = 'I02W'\r\n    // a\r\n    set udg_Database_NumberItems[3] = 1\r\n    set DB_Items[3][1] = 'I02W'\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Freedom_of_Choice takes nothing returns nothing\r\n    set gg_trg_Freedom_of_Choice = CreateTrigger(  )\r\n    call TriggerAddAction( gg_trg_Freedom_of_Choice, function Trig_Freedom_of_Choice_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}