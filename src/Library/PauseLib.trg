{
  "Id": 50332067,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library PauseLib requires UnitLib\r\n\r\n\tglobals\r\n\t\tprivate constant integer HASH_KEY = StringHash( \"pause\" )\r\n\tendglobals\r\n\r\n    function pausest takes unit u, integer toAdd returns nothing\r\n        local integer id = GetHandleId( u )\r\n        local integer counter = LoadInteger( udg_hash, id, HASH_KEY )\r\n        local boolean isActive = LoadBoolean( udg_hash, id, HASH_KEY )\r\n\r\n        if IsMinion(u) == false then\r\n            call SaveInteger( udg_hash, id, HASH_KEY, counter + toAdd )\r\n            set counter = LoadInteger( udg_hash, id, HASH_KEY )\r\n\r\n            if counter >= 1 and isActive == false then\r\n                call SaveBoolean( udg_hash, id, HASH_KEY, true )\r\n                call PauseUnit( u, true )\r\n            elseif counter < 1 and isActive then\r\n                call SaveBoolean( udg_hash, id, HASH_KEY, false )\r\n                call PauseUnit( u, false )\r\n            endif\r\n        elseif toAdd > 0 then\r\n            call PauseUnit( u, true )\r\n        elseif toAdd < 0 then\r\n            call PauseUnit( u, false )\r\n        endif\r\n        \r\n        set u = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}