{
  "Id": 50332071,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library CorrectPlayerLib\r\n\r\n    //Obsolete. Do not use.\r\n    function CorrectPlayer takes unit u returns integer\r\n        local integer cyclA = 1\r\n        local integer i = 0\r\n        loop\r\n            exitwhen cyclA > 4\r\n            if u == udg_hero[cyclA] then\r\n                set i = cyclA\r\n                set cyclA = 4\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        set u = null\r\n        return i\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}