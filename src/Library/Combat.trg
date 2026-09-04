{
  "Id": 50332061,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library CombatLib requires TextLib\r\n\r\n\tprivate function CheckUnit takes unit u returns integer\r\n\t\tif IsUnitType(u, UNIT_TYPE_HERO ) then\r\n\t\t\treturn GetUnitUserData(u)\r\n\t\tendif\r\n\t\treturn GetPlayerId( GetOwningPlayer( u ) ) + 1\r\n\tendfunction\r\n\r\n    function combat takes unit u, boolean showMessage, integer sp returns boolean\r\n        if udg_combatlogic[CheckUnit(u)] == false then\r\n            if showMessage and IsUnitType( u, UNIT_TYPE_HERO) then\r\n                call textst( \"|c00909090Doesn't work outside of combat\", u, 64, 90, 10, 1 )\r\n            endif\r\n            return false\r\n        endif\r\n        return true\r\n    endfunction\r\n\t\r\n\tfunction notCombat takes unit u, boolean showMessage, integer sp returns boolean\r\n        if udg_combatlogic[CheckUnit(u)] then\r\n            if showMessage and IsUnitType( u, UNIT_TYPE_HERO) then\r\n                call textst( \"|c00909090Doesn't work in combat\", u, 64, 90, 10, 1 )\r\n            endif\r\n            return false\r\n        endif\r\n        return true\r\n    endfunction\r\n    \r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}