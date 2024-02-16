{
  "Id": 50332424,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant integer FAKE_COIN_GOLD = 300\r\nendglobals\r\n\r\nfunction Trig_Fake_Coin_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(Event_ItemExchange_Item) == 'I0AZ'\r\nendfunction\r\n\r\nfunction Trig_Fake_Coin_Actions takes nothing returns nothing\r\n    local unit hero = Event_ItemExchange_Hero\r\n\r\n    call DisplayTimedTextToPlayer(GetOwningPlayer(Event_ItemExchange_Hero), 0, 0, 5., \"You were given |cffffcc00\\\"\" + GetItemName(Event_ItemExchange_Item) + \"\\\"|r.\" )\r\n    call RemoveItem( Event_ItemExchange_Item )\r\n    call moneyst( Event_ItemExchange_Hero, FAKE_COIN_GOLD )\r\n    call moneyst( Event_ItemExchange_Friend, FAKE_COIN_GOLD )\r\n    \r\n    set hero = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Fake_Coin takes nothing returns nothing\r\n    call CreateEventTrigger( \"Event_ItemExchange_Real\", function Trig_Fake_Coin_Actions, function Trig_Fake_Coin_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}