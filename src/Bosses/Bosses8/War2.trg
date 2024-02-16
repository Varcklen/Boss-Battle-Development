{
  "Id": 50333607,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope War02 initializer init\r\n\r\n    globals\r\n        private constant integer HEALTH_CHECK = 90\r\n        private constant integer SUMMONED_MINION = 'n03T'\r\n        private constant integer SUMMON_DEVIATION = 400\r\n        \r\n        private constant string ANIMATION = \"Abilities\\\\Spells\\\\NightElf\\\\BattleRoar\\\\RoarCaster.mdl\"\r\n    endglobals\r\n\r\n    function Trig_War2_Conditions takes nothing returns boolean\r\n        return GetUnitTypeId( udg_DamageEventTarget ) == War01_ID_BOSS and GetUnitLifePercent(udg_DamageEventTarget) <= HEALTH_CHECK\r\n    endfunction\r\n\r\n    function Trig_War2_Actions takes nothing returns nothing\r\n        local integer i = 1\r\n\r\n        call DisableTrigger( GetTriggeringTrigger() )\r\n        loop\r\n            exitwhen i > PLAYERS_LIMIT\r\n            if IsUnitAlive(udg_hero[i]) then\r\n                set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), SUMMONED_MINION, Math_GetUnitRandomX(udg_DamageEventTarget, SUMMON_DEVIATION), Math_GetUnitRandomY(udg_DamageEventTarget, SUMMON_DEVIATION), GetRandomReal( 0, 360 ) )\r\n                call PlaySpecialEffect(ANIMATION, bj_lastCreatedUnit)\r\n            endif\r\n            set i = i + 1\r\n        endloop\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        set gg_trg_War2 = CreateEventTrigger( \"udg_AfterDamageEvent\", function Trig_War2_Actions, function Trig_War2_Conditions )\r\n        call DisableTrigger( gg_trg_War2 )\r\n    endfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}