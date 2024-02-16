{
  "Id": 50332080,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library CreateCopyUnitLib\r\n\r\n    globals\r\n        unit CreateUnitCopy_Original\r\n        unit CreateUnitCopy_Copy\r\n        real CreateUnitCopy_Real\r\n    endglobals\r\n\r\n    function CreateUnitCopy takes unit original, real x, real y, real face returns unit\r\n        local unit copy = CreateUnit( GetOwningPlayer( original ), GetUnitTypeId( original ), x, y, face )\r\n        \r\n        call BlzSetUnitMaxHP( copy, BlzGetUnitMaxHP(original) )\r\n        if GetUnitState( original, UNIT_STATE_LIFE) > 0.405 then\r\n            call SetUnitLifePercentBJ( copy, GetUnitLifePercent(original) )\r\n        else\r\n            call SetUnitLifePercentBJ( copy, 100 )\r\n        endif\r\n        call BlzSetUnitBaseDamage( copy, BlzGetUnitBaseDamage(original, 0), 0 )\r\n        call BlzSetUnitArmor( copy, BlzGetUnitArmor(original) )\r\n        call SetUnitMoveSpeed( copy, GetUnitDefaultMoveSpeed(original) )\r\n        \r\n        set CreateUnitCopy_Original = original\r\n        set CreateUnitCopy_Copy = copy\r\n        set CreateUnitCopy_Real = 0.00\r\n        set CreateUnitCopy_Real = 1.00\r\n        set CreateUnitCopy_Real = 0.00\r\n        \r\n        set udg_Temp_Unit = copy\r\n        set copy = null\r\n        set original = null\r\n        return udg_Temp_Unit\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}