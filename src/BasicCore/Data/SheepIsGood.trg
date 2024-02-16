{
  "Id": 50332137,
  "Comment": "Eldrich Moon\r\n\r\nby zihell",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SheepIsGood_Actions takes nothing returns nothing\r\n    set udg_Database_NumberItems[1] = 14\r\n    set DB_Items[1][1] = 'I0AE'\r\n    set DB_Items[1][2] = 'I06T'\r\n    set DB_Items[1][3] = 'I064'\r\n    set DB_Items[1][4] = 'I01H'\r\n    set DB_Items[1][5] = 'I04Z'\r\n    set DB_Items[1][6] = 'I00Y'\r\n    set DB_Items[1][7] = 'I00V'\r\n    set DB_Items[1][8] = 'I0BO'\r\n    set DB_Items[1][9] = 'I06X'\r\n    set DB_Items[1][10] = 'I0BE'\r\n    set DB_Items[1][11] = 'I08V'\r\n    set DB_Items[1][12] = 'I0EW'\r\n    set DB_Items[1][13] = 'I0BG'\r\n    set DB_Items[1][14] = 'I0EY'\r\n    // a\r\n    set udg_Database_NumberItems[2] = 3\r\n    set DB_Items[2][1] = 'I0EX'\r\n    set DB_Items[2][2] = 'I0B3'\r\n    set DB_Items[2][3] = 'I0DE'\r\n    // a\r\n    set udg_Database_NumberItems[3] = 3\r\n    set DB_Items[3][1] = 'I04L'\r\n    set DB_Items[3][2] = 'I0A5'\r\n    set DB_Items[3][3] = 'I06S'\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SheepIsGood takes nothing returns nothing\r\n    set gg_trg_SheepIsGood = CreateTrigger(  )\r\n    call TriggerAddAction( gg_trg_SheepIsGood, function Trig_SheepIsGood_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}