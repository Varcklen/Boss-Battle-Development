{
  "Id": 50332091,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library DummyspawnLib\r\n\r\n    //Obsolete. Do not use\r\n    function dummyspawn takes unit caster, real dur, integer sp1, integer sp2, integer sp3 returns unit\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'u000', GetUnitX( caster ), GetUnitY( caster ), 270 )\r\n        if dur != 0 then\r\n            call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', dur)\r\n        endif    \r\n        if sp1 != 0 then\r\n            call UnitAddAbility( bj_lastCreatedUnit, sp1)\r\n        endif\r\n        if sp2 != 0 then\r\n            call UnitAddAbility( bj_lastCreatedUnit, sp2)\r\n        endif\r\n        if sp3 != 0 then\r\n            call UnitAddAbility( bj_lastCreatedUnit, sp3)\r\n        endif\r\n        \r\n        set caster = null\r\n        return bj_lastCreatedUnit\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}