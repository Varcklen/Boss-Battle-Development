{
  "Id": 50332227,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant integer MODE_TRADE_EXCHANGE_NEW_COST = 50\r\nendglobals\r\n\r\nfunction Trig_Trade_Conditions takes nothing returns boolean\r\n    return udg_modgood[13]\r\nendfunction\r\n\r\nfunction Trig_Trade_Actions takes nothing returns nothing\r\n    set ExchangeCost = MODE_TRADE_EXCHANGE_NEW_COST\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Trade takes nothing returns nothing\r\n    set gg_trg_Trade = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Trade, \"Event_Mode_Awake_Real\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Trade, Condition( function Trig_Trade_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Trade, function Trig_Trade_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}