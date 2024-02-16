{
  "Id": 50333403,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function BossClear takes unit u returns nothing\r\n    local integer s = 1\r\n    local integer n = 1\r\n    local integer k = 1\r\n    local integer h = 0\r\n    local integer cyclA = 1\r\n    local integer cyclB = 1\r\n    local integer i = DB_Boss_id[1][1]\r\n    local boolean l = false\r\n    \r\n    loop\r\n        exitwhen cyclA > 1\r\n        if i == GetUnitTypeId( u ) then\r\n            set cyclB = 1\r\n            set l = false\r\n            loop\r\n                exitwhen l\r\n                set h = cyclB + ( ( s - 1 ) * 10 )\r\n                if DB_Trigger_Boss[n][h] != null and cyclB <= 10 then\r\n                    call DisableTrigger( DB_Trigger_Boss[n][h] )\r\n                    set cyclB = cyclB + 1\r\n                else\r\n                    set l = true\r\n                endif\r\n            endloop\r\n        elseif k < 500 then\r\n            set cyclA = cyclA - 1 \r\n            set s = s + 1\r\n            set i = DB_Boss_id[n][s]\r\n            if i == 0 then\r\n                set s = 1\r\n                set n = n + 1\r\n                set i = DB_Boss_id[n][s]\r\n            endif\r\n        endif\r\n        set k = k + 1\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    set u = null\r\nendfunction\r\n\r\nfunction onRemovalBoss takes unit u returns nothing\r\n    if IsUnitType(u, UNIT_TYPE_ANCIENT) then\r\n        if GetUnitUserData(u) == 5 then\r\n            call RemoveShield(u)\r\n            call BossClear(u)\r\n        endif\r\n    endif\r\n    set u = null\r\nendfunction\r\n\r\nhook RemoveUnit onRemovalBoss",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}