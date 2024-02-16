{
  "Id": 50332781,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope BattlemasterBulwark initializer init\r\n\r\n    globals\r\n        private constant integer ID_ITEM = 'I0GO'\r\n        private constant real BATTLEMASTER_BULWARK_SHIELD_BONUS = 0.4\r\n    endglobals\r\n\r\n    private function AfterDamageEvent_Conditions takes nothing returns boolean\r\n        return IsHeroHasItem( ChoosedHero[GetPlayerId( GetOwningPlayer(udg_DamageEventSource) ) + 1], ID_ITEM) and (GetUnitTypeId(udg_DamageEventSource) == 'u000' or IsUnitType( udg_DamageEventSource, UNIT_TYPE_HERO))\r\n    endfunction\r\n\r\n    private function AfterDamageEvent takes nothing returns nothing\r\n        local unit hero = ChoosedHero[GetPlayerId( GetOwningPlayer(udg_DamageEventSource) ) + 1]\r\n        \r\n        call shield(hero, hero, udg_DamageEventAmount*BATTLEMASTER_BULWARK_SHIELD_BONUS, 60 )\r\n        \r\n        set hero = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger( \"udg_AfterDamageEvent\", function AfterDamageEvent, function AfterDamageEvent_Conditions )\r\n    endfunction\r\n\r\nendscope\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}