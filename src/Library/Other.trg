{
  "Id": 50332112,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library Other requires Conditions\r\n\r\n    globals\r\n        private constant integer GLOW_NORMAL = 'A0D8'\r\n        private constant integer GLOW_SMALL = 'A0UI'\r\n        private constant integer GLOW_BIG = 'A062'\r\n    endglobals\r\n    \r\n    private function Refresh takes unit whichUnit, integer skinId returns nothing\r\n        call UnitRemoveAbility(whichUnit, skinId)\r\n        call UnitAddAbility(whichUnit, skinId)\r\n        set whichUnit = null\r\n    endfunction\r\n\r\n    function SetUnitSkin takes unit whichUnit, integer skinId returns nothing\r\n        call BlzSetUnitSkin( whichUnit, skinId )\r\n            \r\n        if IsUnitHasAbility(whichUnit, GLOW_NORMAL) then\r\n            call Refresh(whichUnit, GLOW_NORMAL)\r\n        elseif IsUnitHasAbility(whichUnit, GLOW_SMALL) then\r\n            call Refresh(whichUnit, GLOW_SMALL)\r\n        elseif IsUnitHasAbility(whichUnit, GLOW_BIG) then\r\n            call Refresh(whichUnit, GLOW_BIG)\r\n        endif\r\n        \r\n        set whichUnit = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}