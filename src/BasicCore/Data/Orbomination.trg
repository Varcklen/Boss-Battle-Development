{
  "Id": 50332139,
  "Comment": "Eldrich Moon\r\n\r\nby zihell",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Orbomination_Actions takes nothing returns nothing\r\n    set udg_Database_NumberItems[1] = 7\r\n    set DB_Items[1][1] = 'I08Y'\r\n    set DB_Items[1][2] = 'I0EP'\r\n    set DB_Items[1][3] = 'I08Z'\r\n    set DB_Items[1][4] = 'I090'\r\n    set DB_Items[1][5] = 'I0FJ'\r\n    set DB_Items[1][6] = 'I0F0'\r\n    set DB_Items[1][7] = 'I0FU'\r\n    // a\r\n    set udg_Database_NumberItems[2] = 7\r\n    set DB_Items[2][1] = 'I08Y'\r\n    set DB_Items[2][2] = 'I0EP'\r\n    set DB_Items[2][3] = 'I08Z'\r\n    set DB_Items[2][4] = 'I090'\r\n    set DB_Items[2][5] = 'I0FJ'\r\n    set DB_Items[2][6] = 'I0F0'\r\n    set DB_Items[2][7] = 'I0FU'\r\n    // a\r\n    set udg_Database_NumberItems[3] = 7\r\n    set DB_Items[3][1] = 'I08Y'\r\n    set DB_Items[3][2] = 'I0EP'\r\n    set DB_Items[3][3] = 'I08Z'\r\n    set DB_Items[3][4] = 'I090'\r\n    set DB_Items[3][5] = 'I0FJ'\r\n    set DB_Items[3][6] = 'I0F0'\r\n    set DB_Items[3][7] = 'I0FU'\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Orbomination takes nothing returns nothing\r\n    set gg_trg_Orbomination = CreateTrigger(  )\r\n    call TriggerAddAction( gg_trg_Orbomination, function Trig_Orbomination_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}