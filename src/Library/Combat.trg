{
  "Id": 50332061,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library CombatLib requires TextLib\r\n\r\n\tprivate function CheckUnit takes unit u returns integer\r\n\t\tif IsUnitType(u, UNIT_TYPE_HERO ) then\r\n\t\t\treturn GetUnitUserData(u)\r\n\t\tendif\r\n\t\treturn GetPlayerId( GetOwningPlayer( u ) ) + 1\r\n\tendfunction\r\n\r\n    function combat takes unit u, boolean b, integer sp returns boolean\r\n    \tlocal integer index = CheckUnit(u)\r\n        if udg_combatlogic[index] == false then\r\n            if b and IsUnitType( u, UNIT_TYPE_HERO) and GetSpellAbilityId() == sp then\r\n                call textst( \"|c00909090 Doesn't work out of combat\", u, 64, 90, 10, 1 )\r\n            endif\r\n            return false\r\n        endif\r\n        return true\r\n    endfunction\r\n\t\r\n\tfunction notCombat takes unit u, boolean b, integer sp returns boolean\r\n\t\tlocal integer index = CheckUnit(u)\r\n        if udg_combatlogic[index] then\r\n            if b and IsUnitType( u, UNIT_TYPE_HERO) and GetSpellAbilityId() == sp then\r\n                call textst( \"|c00909090 Doesn't work in combat\", u, 64, 90, 10, 1 )\r\n            endif\r\n            return false\r\n        endif\r\n        return true\r\n    endfunction\r\n    \r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}