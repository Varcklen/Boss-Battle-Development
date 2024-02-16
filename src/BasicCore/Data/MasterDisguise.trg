{
  "Id": 50332132,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MasterDisguise_Actions takes nothing returns nothing\r\n    set udg_Database_NumberItems[1] = 1\r\n    set DB_Items[1][1] = 'I023'\r\n    set udg_Database_NumberItems[2] = 1\r\n    set DB_Items[2][1] = 'I023'\r\n    set udg_Database_NumberItems[3] = 1\r\n    set DB_Items[3][1] = 'I023'\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MasterDisguise takes nothing returns nothing\r\n    set gg_trg_MasterDisguise = CreateTrigger(  )\r\n    call TriggerAddAction( gg_trg_MasterDisguise, function Trig_MasterDisguise_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}