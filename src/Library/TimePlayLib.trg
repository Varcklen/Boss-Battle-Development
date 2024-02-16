{
  "Id": 50332106,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library TimePlayLib\r\n\r\n    private function bufend takes nothing returns nothing\r\n        local integer id = GetHandleId( GetExpiredTimer() )\r\n        local string str = LoadStr( udg_hash, id, 1 )\r\n        local integer g = StringHash( str )\r\n        local integer sp = LoadInteger( udg_hash, id, StringHash( str+\"1\" ) )\r\n        local integer bf = LoadInteger( udg_hash, id, StringHash( str+\"2\" ) )\r\n        local unit u = LoadUnitHandle( udg_hash, id, g )\r\n        \r\n        call UnitRemoveAbility( u, sp )\r\n        call UnitRemoveAbility( u, bf )\r\n        call FlushChildHashtable( udg_hash, id )\r\n        \r\n        set u = null\r\n    endfunction\r\n\r\n    function bufst takes unit caster, unit target, integer sp, integer bf, string str, real t returns nothing\r\n        local integer id = GetHandleId( target )\r\n        local integer g = StringHash( str )\r\n        local real h = t + 0.01\r\n\r\n        call UnitAddAbility( target, sp )\r\n        \r\n        if LoadTimerHandle( udg_hash, id, g ) == null then\r\n            call SaveTimerHandle( udg_hash, id, g, CreateTimer() )\r\n        endif\r\n        set id = GetHandleId( LoadTimerHandle( udg_hash, id, g ) ) \r\n        call SaveInteger( udg_hash, id, g, sp )\r\n        call SaveUnitHandle( udg_hash, id, g, target )\r\n        call SaveStr( udg_hash, id, 1, str )\r\n        call SaveInteger( udg_hash, id, StringHash( str+\"1\" ), sp )\r\n        call SaveInteger( udg_hash, id, StringHash( str+\"2\" ), bf )\r\n        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( target ), g ), h, false, function bufend )\r\n        \r\n        set caster = null\r\n        set target = null\r\n    endfunction\r\n\r\nendlibrary\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}