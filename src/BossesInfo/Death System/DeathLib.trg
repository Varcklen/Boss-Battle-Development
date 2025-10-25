{
  "Id": 50332066,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library DeathLib requires TextLib\r\n\r\n    function IsUnitAlive takes unit myUnit returns boolean\r\n        /*if GetUnitState( myUnit, UNIT_STATE_LIFE) > 0.405 then\r\n            return true\r\n        endif*/\r\n        return (GetUnitState( myUnit, UNIT_STATE_LIFE) > 0.405)\r\n    endfunction\r\n\r\n    function IsUnitDead takes unit myUnit returns boolean\r\n        /*if GetUnitState( myUnit, UNIT_STATE_LIFE) <= 0.405 then\r\n            return true\r\n        endif*/\r\n        return (GetUnitState( myUnit, UNIT_STATE_LIFE) <= 0.405)\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}