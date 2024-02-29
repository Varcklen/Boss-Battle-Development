{
  "Id": 50332513,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope RuneStoneSton initializer init\r\n\r\n    globals\r\n        private constant integer ID_ITEM = 'I00M'\r\n        private constant integer DURATION = 5\r\n        \r\n        private constant integer EFFECT = 'A0WL'\r\n        private constant integer BUFF = 'B018'\r\n    endglobals\r\n\r\n    function Trig_Runestone_Ston_Conditions takes nothing returns boolean\r\n        return udg_IsDamageSpell == false and IsHeroHasItem(udg_DamageEventSource,  ID_ITEM )\r\n    endfunction\r\n\r\n    function Trig_Runestone_Ston_Actions takes nothing returns nothing\r\n        local integer id \r\n        local unit caster = udg_DamageEventSource\r\n        local unit target = udg_DamageEventTarget\r\n        local real duration = timebonus(caster, DURATION)\r\n        \r\n        call bufst(caster, target, EFFECT, BUFF, \"ston\", duration )\r\n        \r\n        set caster = null\r\n        set target = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger(\"udg_AfterDamageEvent\", function Trig_Runestone_Ston_Actions, function Trig_Runestone_Ston_Conditions )\r\n    endfunction\r\n\r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}