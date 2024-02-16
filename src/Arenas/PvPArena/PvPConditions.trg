{
  "Id": 50333702,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library PvPConditions\r\n    \r\n    function IsUnitInDuel takes unit myUnit returns boolean\r\n        local boolean inDuel = false\r\n    \r\n        if myUnit == udg_unit[57] then\r\n            set inDuel = true\r\n        elseif myUnit == udg_unit[58] then\r\n            set inDuel = true\r\n        endif\r\n    \r\n        set myUnit = null\r\n        return inDuel\r\n    endfunction\r\n    \r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}