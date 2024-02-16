{
  "Id": 50333435,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Totem4 initializer init\r\n\r\n    globals\r\n        private constant integer HEALTH_CHECK = 25\r\n    endglobals\r\n\r\n    function Trig_Totem4_Conditions takes nothing returns boolean\r\n        return GetUnitTypeId( udg_DamageEventTarget ) == Totem1_ID_BOSS and GetUnitLifePercent( udg_DamageEventTarget ) <= HEALTH_CHECK\r\n    endfunction\r\n\r\n    function Trig_Totem4_Actions takes nothing returns nothing\r\n        call DisableTrigger( GetTriggeringTrigger() )\r\n        call Totem2_SpawnShadows(udg_DamageEventTarget)\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        set gg_trg_Totem4 = CreateEventTrigger( \"udg_AfterDamageEvent\", function Trig_Totem4_Actions, function Trig_Totem4_Conditions )\r\n        call DisableTrigger( gg_trg_Totem4 )\r\n    endfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}