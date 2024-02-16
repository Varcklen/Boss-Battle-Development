{
  "Id": 50333717,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function onRemoval takes unit u returns nothing\r\n    call FlushChildHashtable( udg_hash, GetHandleId( u ) )\r\n    set u = null\r\nendfunction\r\n\r\nhook RemoveUnit onRemoval",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}