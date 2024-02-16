{
  "Id": 50332622,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library MajyteLib requires SpellPower\r\n\r\n    function MajyteCast takes nothing returns nothing\r\n        local integer id = GetHandleId( GetExpiredTimer( ) )\r\n        local unit u = LoadUnitHandle( udg_hash, id, StringHash( \"majt\" ) )\r\n        local boolean l = LoadBoolean( udg_hash, GetHandleId( u ), StringHash( \"majt\" ) )\r\n\r\n        if GetUnitAbilityLevel( u, 'A0YC') > 0 and l then\r\n            call spdst( u, -1 * LoadReal( udg_hash, GetHandleId( u ), StringHash( \"majt\" ) ) )\r\n            call UnitRemoveAbility( u, 'A0YC' )\r\n            call UnitRemoveAbility( u, 'B03Z' )\r\n        call SaveBoolean( udg_hash, GetHandleId(u), StringHash( \"majt\" ), false )\r\n            call RemoveSavedReal( udg_hash, GetHandleId( u ), StringHash( \"majt\" ) )\r\n            call FlushChildHashtable( udg_hash, id )\r\n        endif\r\n        \r\n        set u = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}