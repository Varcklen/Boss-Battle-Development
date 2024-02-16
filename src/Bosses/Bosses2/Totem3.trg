{
  "Id": 50333434,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Totem3 initializer init\r\n\r\n    globals\r\n        private constant integer HEALTH_CHECK = 50\r\n        private constant integer EXPLODE_COOLDOWN = 3\r\n    endglobals\r\n\r\n    private function Trig_Totem3_Conditions takes nothing returns boolean\r\n        return GetUnitTypeId( udg_DamageEventTarget ) == Totem1_ID_BOSS and GetUnitLifePercent( udg_DamageEventTarget ) <= HEALTH_CHECK\r\n    endfunction\r\n\r\n    private function Trig_Totem3_Actions takes nothing returns nothing\r\n        call DisableTrigger( GetTriggeringTrigger() )\r\n        call InvokeTimerWithUnit(udg_DamageEventTarget, \"bstm1\", bosscast(EXPLODE_COOLDOWN), true, function Totem1_TotemCast )\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        set gg_trg_Totem3 = CreateEventTrigger( \"udg_AfterDamageEvent\", function Trig_Totem3_Actions, function Trig_Totem3_Conditions )\r\n        call DisableTrigger( gg_trg_Totem3 )\r\n    endfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}