{
  "Id": 50332071,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library CorrectPlayerLib\r\n\r\n    function CorrectPlayer takes unit u returns integer\r\n        return GetUnitUserData(u)\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}