{
  "Id": 50333609,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope War04 initializer init\r\n\r\n    globals\r\n        private constant integer HEALTH_CHECK = 50\r\n        private constant integer SUMMONED_MINION = 'n03U'\r\n        private constant integer SUMMON_DEVIATION = 400\r\n        \r\n        private constant string ANIMATION = \"Abilities\\\\Spells\\\\NightElf\\\\BattleRoar\\\\RoarCaster.mdl\"\r\n    endglobals\r\n\r\n    function Trig_War4_Conditions takes nothing returns boolean\r\n        return GetUnitTypeId( udg_DamageEventTarget ) == War01_ID_BOSS and GetUnitLifePercent(udg_DamageEventTarget) <= HEALTH_CHECK\r\n    endfunction\r\n\r\n    function Trig_War4_Actions takes nothing returns nothing\r\n        call DisableTrigger( GetTriggeringTrigger() )\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), SUMMONED_MINION, Math_GetUnitRandomX(udg_DamageEventTarget, SUMMON_DEVIATION), Math_GetUnitRandomY(udg_DamageEventTarget, SUMMON_DEVIATION), GetRandomReal( 0, 360 ) )\r\n        call PlaySpecialEffect(ANIMATION, bj_lastCreatedUnit)\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        set gg_trg_War4 = CreateEventTrigger( \"udg_AfterDamageEvent\", function Trig_War4_Actions, function Trig_War4_Conditions )\r\n        call DisableTrigger( gg_trg_War4 )\r\n    endfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}