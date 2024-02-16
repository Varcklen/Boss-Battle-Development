{
  "Id": 50332067,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library PauseLib\r\n\r\n    function pausest takes unit u, integer i returns nothing\r\n        local integer k = GetPlayerId(GetOwningPlayer( u )) + 1\r\n        local integer g = LoadInteger( udg_hash, GetHandleId( u ), StringHash( \"pause\" ) )\r\n        local boolean b = LoadBoolean( udg_hash, GetHandleId( u ), StringHash( \"pause\" ) )\r\n\r\n        if IsUnitType( u, UNIT_TYPE_HERO) or IsUnitType( u, UNIT_TYPE_ANCIENT) then\r\n            call SaveInteger( udg_hash, GetHandleId( u ), StringHash( \"pause\" ), g + i )\r\n            set g = LoadInteger( udg_hash, GetHandleId( u ), StringHash( \"pause\" ) )\r\n\r\n            if g >= 1 and not(b) then\r\n                call SaveBoolean( udg_hash, GetHandleId( u ), StringHash( \"pause\" ), true )\r\n                call PauseUnit( u, true )\r\n            elseif g < 1 and b then\r\n                call SaveBoolean( udg_hash, GetHandleId( u ), StringHash( \"pause\" ), false )\r\n                call PauseUnit( u, false )\r\n            endif\r\n        elseif i > 0 then\r\n            call PauseUnit( u, true )\r\n        elseif i < 0 then\r\n            call PauseUnit( u, false )\r\n        endif\r\n        \r\n        set u = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}