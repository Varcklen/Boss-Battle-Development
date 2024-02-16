{
  "Id": 50332052,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library TextLib\r\n\r\n    globals\r\n        private constant real FADE_TIME = 0.5\r\n        private constant integer SATURATION = 225\r\n    endglobals\r\n\r\n    function B2S takes boolean b returns string\r\n        if b then\r\n            return \"true\"\r\n        else\r\n            return \"false\"\r\n        endif\r\n    endfunction\r\n\r\n    function textst takes string inf, unit caster, real speed, real angle, real size, real life returns nothing\r\n        local texttag txt = CreateTextTag()\r\n        local real sp = ( speed * 0.071 / 128 ) * Cos( angle * 0.0174 )\r\n        local real an = ( speed * 0.071 / 128 ) * Sin( angle * 0.0174 )\r\n        local real pos = 0\r\n        \r\n        if udg_logic[32] then\r\n            set udg_logic[32] = false\r\n            set pos = -100\r\n        endif\r\n        \r\n        call SetTextTagText( txt, inf, size * 0.023 / 10 ) \r\n        call SetTextTagPosUnit( txt, caster, pos ) \r\n        call SetTextTagColor( txt, SATURATION, SATURATION, SATURATION, SATURATION ) \r\n        call SetTextTagVelocity( txt, sp , an )\r\n        call SetTextTagFadepoint( txt, life ) \r\n        call SetTextTagLifespan( txt, life + FADE_TIME ) \r\n        call SetTextTagPermanent( txt, false )\r\n        \r\n        set txt = null\r\n        set caster = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}