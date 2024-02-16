{
  "Id": 50332616,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope LearningCurve initializer init\r\n\r\n    globals\r\n        private constant integer ID_ITEM = 'I03V'\r\n        \r\n        private constant integer LEVEL_BONUS = 2\r\n    endglobals\r\n                \r\n    private function EndOfLostBattle_Conditions takes nothing returns boolean\r\n        return IsHeroHasItem(Event_EndOfLostBattle_Hero, ID_ITEM)\r\n    endfunction\r\n    \r\n    private function EndOfLostBattle takes nothing returns nothing\r\n        call SetHeroLevel(Event_EndOfLostBattle_Hero, GetHeroLevel(Event_EndOfLostBattle_Hero) + LEVEL_BONUS, false)\r\n    endfunction\r\n\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger( \"Event_EndOfLostBattle_Real\", function EndOfLostBattle, function EndOfLostBattle_Conditions )\r\n    endfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}