{
  "Id": 50332071,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library CorrectPlayerLib\r\n\r\n    function CorrectPlayer takes unit u returns integer\r\n    \tif IsUnitType( u, UNIT_TYPE_HERO) then\r\n    \t\treturn GetUnitUserData(u)\r\n    \tendif\r\n        return GetPlayerId( GetOwningPlayer( u ) ) + 1\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}