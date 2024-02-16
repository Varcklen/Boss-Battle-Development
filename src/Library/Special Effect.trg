{
  "Id": 50332065,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library SpecialEffect\r\n\r\n    globals\r\n        private effect Effect = null\r\n    endglobals\r\n\r\n    function AddSpecialEffectToUnit takes string myEffect, unit myUnit returns effect\r\n        set Effect = AddSpecialEffect( myEffect, GetUnitX( myUnit ), GetUnitY( myUnit ) )\r\n        return Effect\r\n    endfunction\r\n    \r\n    function PlaySpecialEffect takes string myEffect, unit myUnit returns nothing\r\n        call DestroyEffect( AddSpecialEffect( myEffect, GetUnitX( myUnit ), GetUnitY( myUnit ) ) )\r\n    endfunction\r\n    \r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}