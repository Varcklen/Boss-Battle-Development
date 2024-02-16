{
  "Id": 50332918,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope MixtureOfIllusions initializer init\r\n\r\n    globals\r\n        private constant integer ID_ITEM =  'I0E1'\r\n    endglobals\r\n\r\n    private function AfterHeal_Conditions takes nothing returns boolean\r\n        return IsHealFromPotion and IsHeroHasItem( Event_AfterHeal_Caster, ID_ITEM )\r\n    endfunction\r\n    \r\n    private function AfterHeal takes nothing returns nothing\r\n        local integer i = 1\r\n        local unit caster = Event_AfterHeal_Caster\r\n        local unit hero\r\n        local real heal = Event_AfterHeal_Heal\r\n        \r\n        loop\r\n            exitwhen i > PLAYERS_LIMIT\r\n            set hero = udg_hero[i]\r\n            if hero != caster and IsUnitAlive( udg_hero[i] ) and IsUnitAlly( hero, GetOwningPlayer( caster ) ) then\r\n                call healst( caster, hero, heal )\r\n            endif\r\n            set i = i + 1\r\n        endloop\r\n        \r\n        set caster = null\r\n        set hero = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger(\"Event_AfterHeal_Real\", function AfterHeal, function AfterHeal_Conditions )\r\n    endfunction\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}