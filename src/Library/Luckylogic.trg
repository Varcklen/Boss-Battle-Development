{
  "Id": 50332057,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library LuckylogicLib requires Luck\r\n\r\n    private function OtherUses takes unit u, integer k returns integer\r\n        local integer ch = k\r\n        if inv(u, 'I01E') > 0 then\r\n            set ch = ch * 2\r\n        endif\r\n        \r\n        set u = null\r\n        return ch\r\n    endfunction\r\n\r\n    //Use this if you need to set the minimum and maximum edges of a die. Otherwise use LuckChance.\r\n    function luckylogic takes unit u, integer ch, integer min, integer max returns boolean\r\n        local boolean l = false\r\n        \r\n        if GetRandomInt( min, max ) <= ( OtherUses(u, ch) + GetUnitLuck(u) ) then\r\n            set l = true\r\n        endif\r\n        set u = null\r\n        return l\r\n    endfunction\r\n\r\n    function LuckChance takes unit u, integer ch returns boolean\r\n        return luckylogic(u, ch, 1, 100 )\r\n        set u = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}