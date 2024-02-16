{
  "Id": 50332115,
  "Comment": "Base damage getter that accounts for the one die one side portion of damage that is ignored otherwise\r\nUpdated all damage functions i remember about ",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library IsSetItemLib\r\n\r\n    function IsSetItem takes integer it, integer settag returns boolean\r\n        local integer cyclA = 1\r\n        local integer cyclAEnd = udg_DB_SetItems_Num[settag]\r\n        local boolean is = false\r\n        \r\n        loop \r\n            exitwhen cyclA > cyclAEnd\r\n            if it == DB_SetItems[settag][cyclA] then\r\n                set is = true\r\n                set cyclA = cyclAEnd\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        \r\n        return is\r\n    endfunction\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}