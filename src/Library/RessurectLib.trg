{
  "Id": 50332094,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library RessurectLib\r\n\r\n    function resst takes player p, real x, real y, real fac returns unit\r\n        local integer i = GetPlayerId( p ) + 1\r\n        local integer k = deadminionlim[i]\r\n        local integer rand\r\n        \r\n        if k > 0 then\r\n            set rand = GetRandomInt(1, k)\r\n            set bj_lastCreatedUnit = CreateUnit( p, deadminion[i][rand], x, y, fac )\r\n            call BlzSetUnitBaseDamage( bj_lastCreatedUnit, deadminionat[i][rand], 0 )\r\n            call BlzSetUnitMaxHP( bj_lastCreatedUnit, deadminionhp[i][rand] )\r\n            call SetUnitState( bj_lastCreatedUnit, UNIT_STATE_LIFE, GetUnitState( bj_lastCreatedUnit, UNIT_STATE_MAX_LIFE) )\r\n        else\r\n            set bj_lastCreatedUnit = null\r\n        endif\r\n        set p = null\r\n        return bj_lastCreatedUnit \r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}