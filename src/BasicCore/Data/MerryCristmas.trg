{
  "Id": 50332131,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MerryCristmas_Actions takes nothing returns nothing\r\n    set udg_Database_NumberItems[1] = 14\r\n    set DB_Items[1][1] = 'I05N'\r\n    set DB_Items[1][2] = 'I05G'\r\n    set DB_Items[1][3] = 'I0CL'\r\n    set DB_Items[1][4] = 'I06Y'\r\n    set DB_Items[1][5] = 'I04V'\r\n    set DB_Items[1][6] = 'I0A1'\r\n    set DB_Items[1][7] = 'I03Q'\r\n    set DB_Items[1][8] = 'I0BG'\r\n    set DB_Items[1][9] = 'I04N'\r\n    set DB_Items[1][10] = 'I04M'\r\n    set DB_Items[1][11] = 'I03X'\r\n    set DB_Items[1][12] = 'I065'\r\n    set DB_Items[1][13] = 'I063'\r\n    set DB_Items[1][14] = 'I02W'\r\n    set udg_Database_NumberItems[2] = 14\r\n    set DB_Items[2][1] = 'I05N'\r\n    set DB_Items[2][2] = 'I05G'\r\n    set DB_Items[2][3] = 'I0CL'\r\n    set DB_Items[2][4] = 'I06Y'\r\n    set DB_Items[2][5] = 'I04V'\r\n    set DB_Items[2][6] = 'I0A1'\r\n    set DB_Items[2][7] = 'I03Q'\r\n    set DB_Items[2][8] = 'I0BG'\r\n    set DB_Items[2][9] = 'I04N'\r\n    set DB_Items[2][10] = 'I04M'\r\n    set DB_Items[2][11] = 'I03X'\r\n    set DB_Items[2][12] = 'I065'\r\n    set DB_Items[2][13] = 'I063'\r\n    set DB_Items[2][14] = 'I02W'\r\n    set udg_Database_NumberItems[3] = 14\r\n    set DB_Items[3][1] = 'I05N'\r\n    set DB_Items[3][2] = 'I05G'\r\n    set DB_Items[3][3] = 'I0CL'\r\n    set DB_Items[3][4] = 'I06Y'\r\n    set DB_Items[3][5] = 'I04V'\r\n    set DB_Items[3][6] = 'I0A1'\r\n    set DB_Items[3][7] = 'I03Q'\r\n    set DB_Items[3][8] = 'I0BG'\r\n    set DB_Items[3][9] = 'I04N'\r\n    set DB_Items[3][10] = 'I04M'\r\n    set DB_Items[3][11] = 'I03X'\r\n    set DB_Items[3][12] = 'I065'\r\n    set DB_Items[3][13] = 'I063'\r\n    set DB_Items[3][14] = 'I02W'\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MerryCristmas takes nothing returns nothing\r\n    set gg_trg_MerryCristmas = CreateTrigger(  )\r\n    call TriggerAddAction( gg_trg_MerryCristmas, function Trig_MerryCristmas_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}