{
  "Id": 50333237,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope IncarnationE initializer init\r\n\r\n    globals\r\n        private constant integer ID_ABILITY = 'A0UJ'\r\n        private constant real DAMAGE_BONUS_FIRST_LEVEL = 0.25\r\n        private constant real DAMAGE_BONUS_LEVEL_BONUS = 0.15\r\n    endglobals\r\n\r\n    private function OnDamageChange_Conditions takes nothing returns boolean\r\n        return udg_IsDamageSpell and IsUnitHasAbility(udg_hero[GetPlayerId( GetOwningPlayer(udg_DamageEventSource) ) + 1], ID_ABILITY)\r\n    endfunction\r\n    \r\n    private function OnDamageChange takes nothing returns nothing\r\n        local unit hero = udg_hero[GetPlayerId( GetOwningPlayer(udg_DamageEventSource) ) + 1]\r\n        local integer level = GetUnitAbilityLevel(hero, ID_ABILITY)\r\n        local real extraDamage = DAMAGE_BONUS_FIRST_LEVEL + (DAMAGE_BONUS_LEVEL_BONUS*level)\r\n        local real reverseHealth = 1 - (GetHealthPercent(hero)/100)\r\n    \r\n        set udg_DamageEventAmount = udg_DamageEventAmount + ( Event_OnDamageChange_StaticDamage * extraDamage * reverseHealth )\r\n        \r\n        set hero = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger(\"Event_OnDamageChange_Real\", function OnDamageChange, function OnDamageChange_Conditions)\r\n    endfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}