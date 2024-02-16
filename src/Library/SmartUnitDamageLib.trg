{
  "Id": 50332114,
  "Comment": "Base damage getter that accounts for the one die one side portion of damage that is ignored otherwise\r\nUpdated all damage functions i remember about ",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library SmartUnitDamageLib\r\n\r\n    function GetUnitAvgDiceDamage takes unit u returns integer\r\n        local integer damage = R2I( (BlzGetUnitDiceNumber(u, 0) * (BlzGetUnitDiceSides(u, 0) + 1)) / 2) \r\n        set u = null\r\n        return damage\r\n    endfunction\r\n\r\n    function GetUnitDamage takes unit u returns integer\r\n        local integer damage = BlzGetUnitBaseDamage(u, 0) + GetUnitAvgDiceDamage(u)\r\n        set u = null\r\n        return damage\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}