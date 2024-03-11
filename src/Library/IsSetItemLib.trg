{
  "Id": 50332115,
  "Comment": "item set check that includes charizard",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library IsSetItemLib\r\n    \r\n    globals\r\n    \tprivate constant integer CHARIZARD_ID = 'I03I'\r\n    \tprivate constant integer WEAPON_TAG = 2\r\n    endglobals\r\n    \r\n    function IsSetItem takes integer it, integer settag returns boolean\r\n        local integer i = 1\r\n        local integer iEnd = udg_DB_SetItems_Num[settag]\r\n        \r\n        if it == CHARIZARD_ID and settag != WEAPON_TAG then\r\n        \treturn true\r\n        else\r\n        \tloop \r\n            \texitwhen i > iEnd\r\n            \tif it == DB_SetItems[settag][i] then\r\n                \treturn true\r\n            \tendif\r\n            \tset i = i + 1\r\n        \tendloop\r\n        endif\r\n        return false\r\n    endfunction\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}