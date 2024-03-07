{
  "Id": 50332115,
  "Comment": "item set check that includes charizard",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library IsSetItemLib\r\n    \r\n    function IsSetItem takes integer it, integer settag returns boolean\r\n        local integer cyclA = 1\r\n        local integer cyclAEnd = udg_DB_SetItems_Num[settag]\r\n        local boolean is = false\r\n        local integer CHARIZARD_ID = 'I03I'\r\n    \tlocal integer WEAPON_TAG = 2\r\n        if (it == CHARIZARD_ID) and (settag != WEAPON_TAG) then\r\n        \tset is = true\r\n        else\r\n        \tloop \r\n            \texitwhen cyclA > cyclAEnd\r\n            \tif it == DB_SetItems[settag][cyclA] then\r\n                \tset is = true\r\n                \tset cyclA = cyclAEnd\r\n            \tendif\r\n            \tset cyclA = cyclA + 1\r\n        \tendloop\r\n        endif\r\n        return is\r\n    endfunction\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}