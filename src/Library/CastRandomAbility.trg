{
  "Id": 50332095,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library CastRandomAbility\r\n\r\n    function CastRandomAbility takes unit caster, integer level, trigger usedTrigger returns nothing\r\n        if caster == null or usedTrigger == null or level < 0 or level > 5 then\r\n            call BJDebugMsg(\"Warning! Cannot use random ability!\")\r\n            call BJDebugMsg(\"caster: \" + GetUnitName(caster) )\r\n            call BJDebugMsg(\"level: \" + I2S(level) )\r\n            if usedTrigger == null then\r\n                call BJDebugMsg(\"usedTrigger is null\")\r\n            endif\r\n            return\r\n        endif\r\n    \r\n        set udg_RandomLogic = true\r\n        set udg_Caster = caster\r\n        set udg_Level = level\r\n        set RandomMode = true\r\n        call TriggerExecute( usedTrigger )\r\n        set RandomMode = false\r\n        \r\n        set caster = null\r\n        set usedTrigger = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}