{
  "Id": 50333070,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope ShepherdECountDagotUr initializer init\r\n\r\n    globals\r\n        private constant integer ID_ABILITY_CHECKED = 'A1DP'\r\n        private constant integer ID_ITEM = 'I09B'\r\n    endglobals\r\n\r\n    function Trig_ShepherdECountDagotUr_Conditions takes nothing returns boolean\r\n        return udg_IsDamageSpell == false and IsHeroHasItem( udg_DamageEventSource,  ID_ITEM ) and GetUnitAbilityLevel( udg_DamageEventSource, ID_ABILITY_CHECKED ) > 0\r\n    endfunction\r\n\r\n    function Trig_ShepherdECountDagotUr_Actions takes nothing returns nothing\r\n        local unit caster = udg_DamageEventSource\r\n        local unit target = udg_DamageEventTarget\r\n        \r\n        call debuffst( caster, target, null, 1, 0 )\r\n        \r\n        set caster = null\r\n        set target = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger(\"udg_AfterDamageEvent\", function Trig_ShepherdECountDagotUr_Actions, function Trig_ShepherdECountDagotUr_Conditions )\r\n    endfunction\r\n\r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}