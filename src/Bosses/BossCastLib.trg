{
  "Id": 50333408,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library BossCastLib\r\n\r\n    function bosscast takes real r returns real\r\n        local real n = r\r\n\r\n        if udg_logic[101] then\r\n            set n = n - (0.2*r)\r\n        endif\r\n        if udg_modbad[22] then\r\n            set n = n - (0.1*r)\r\n        endif\r\n        if udg_Endgame > 1 then\r\n            set n = n - (0.1*(udg_Endgame-1))\r\n        endif\r\n        if n < 0.2*r then\r\n            set n = 0.2*r\r\n        endif\r\n        return n\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}