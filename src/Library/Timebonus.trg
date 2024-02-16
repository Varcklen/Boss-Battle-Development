{
  "Id": 50332074,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library TimebonusLib requires SetCount\r\n\r\n    function timebonus takes unit u, real r returns real\r\n        local real t = r\r\n        local integer i = GetUnitUserData(u)\r\n        \r\n        set t = t + (udg_RandomBonus_BuffDuration[i]*r)\r\n        \r\n        if inv( u, 'I0D1' ) > 0 then\r\n            set t = t + (0.5*r)\r\n        endif\r\n        if udg_modgood[28] then\r\n            set t = t + (0.25*r)\r\n        endif\r\n        if inv( u, 'I0GG' ) > 0 then\r\n            set t = t + (SetCount_GetPieces(u, SET_MECH)*0.15*r)\r\n        endif\r\n\r\n        set u = null\r\n        return t\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}