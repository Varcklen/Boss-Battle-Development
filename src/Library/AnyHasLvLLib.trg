{
  "Id": 50332076,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library AnyHasLvLLib\r\n\r\n    function AnyHasLvL takes integer i returns boolean\r\n        local integer cyclA = 1\r\n        local boolean l = false\r\n        \r\n        loop\r\n            exitwhen cyclA > 4\r\n            if udg_LvL[cyclA] >= i then\r\n                set l = true\r\n                set cyclA = 4\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        return l\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}