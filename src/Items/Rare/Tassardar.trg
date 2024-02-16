{
  "Id": 50332692,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Tassardar initializer init\r\n\r\n    globals\r\n        private constant integer ID_ITEM = 'I04O'\r\n        \r\n        private constant string ANIMATION = \"Abilities\\\\Spells\\\\Human\\\\MarkOfChaos\\\\MarkOfChaosDone.mdl\"\r\n    endglobals\r\n\r\n    private function SomeoneDied_Conditions takes nothing returns boolean\r\n        return IsHeroHasItem( Event_SomeoneDied_Unit, ID_ITEM) and IsUnitAlive( Event_SomeoneDied_Unit)\r\n    endfunction\r\n\r\n    private function TassardarEnd takes nothing returns nothing\r\n        local integer id = GetHandleId( GetExpiredTimer( ) )\r\n        local unit hero = LoadUnitHandle( udg_hash, id, StringHash( \"tsss\" ) )\r\n\r\n        call spectimeunit( hero, ANIMATION, \"origin\", 2 )\r\n        call BlzEndUnitAbilityCooldown( hero, udg_Ability_Uniq[GetUnitUserData(hero)] )\r\n        call FlushChildHashtable( udg_hash, id )\r\n        \r\n        set hero = null\r\n    endfunction\r\n\r\n    private function SomeoneDied takes nothing returns nothing\r\n        call InvokeTimerWithUnit(Event_SomeoneDied_Unit, \"tsss\", 0.01, false, function TassardarEnd )\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger( \"Event_SomeoneDied_Real\", function SomeoneDied, function SomeoneDied_Conditions )\r\n    endfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}