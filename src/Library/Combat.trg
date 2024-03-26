{
  "Id": 50332061,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library CombatLib requires TextLib\r\n\r\n    function combat takes unit u, boolean b, integer sp returns boolean\r\n        if udg_combatlogic[GetPlayerId( GetOwningPlayer( u ) ) + 1] == false then\r\n            if b and IsUnitInGroup( u, udg_heroinfo ) and GetSpellAbilityId() == sp then\r\n                call textst( \"|c00909090 Doesn't work out of combat\", u, 64, 90, 10, 1 )\r\n            endif\r\n            return false\r\n        endif\r\n        return true\r\n    endfunction\r\n\t\r\n\tfunction notCombat takes unit u, boolean b, integer sp returns boolean\r\n        if udg_combatlogic[GetPlayerId( GetOwningPlayer( u ) ) + 1] then\r\n            if b and IsUnitInGroup( u, udg_heroinfo ) and GetSpellAbilityId() == sp then\r\n                call textst( \"|c00909090 Doesn't work in combat\", u, 64, 90, 10, 1 )\r\n            endif\r\n            return false\r\n        endif\r\n        return true\r\n    endfunction\r\n    \r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}