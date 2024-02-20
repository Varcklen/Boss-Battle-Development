{
  "Id": 50333078,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library TrashCollector\r\n\r\n    private function OnRemoveUnit takes unit u returns nothing\r\n        call FlushChildHashtable( udg_hash, GetHandleId(u) )\r\n    endfunction\r\n    \r\n    private function OnRemoveItem takes item it returns nothing\r\n        call FlushChildHashtable( udg_hash, GetHandleId(it) )\r\n    endfunction\r\n    \r\n    private function OnRemoveTimer takes timer tim returns nothing\r\n        call FlushChildHashtable( udg_hash, GetHandleId(tim) )\r\n    endfunction\r\n\r\n    hook RemoveUnit OnRemoveUnit\r\n    hook RemoveItem OnRemoveItem\r\n    hook DestroyTimer OnRemoveTimer\r\n    \r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}