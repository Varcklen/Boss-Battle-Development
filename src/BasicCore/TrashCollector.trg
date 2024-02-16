{
  "Id": 50333078,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library TrashCollector\r\n\r\n    private function OnRemove takes unit u returns nothing\r\n        call FlushChildHashtable( udg_hash, GetHandleId(u) )\r\n    endfunction\r\n\r\n    hook RemoveUnit OnRemove\r\n    \r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}