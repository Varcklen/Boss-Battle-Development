{
  "Id": 50332616,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope LearningCurve initializer init\r\n\r\n    globals\r\n        private constant integer ITEM_ID = 'I03V'\r\n        \r\n        private constant integer LEVEL_BONUS = 2\r\n    endglobals\r\n                \r\n    private function condition takes nothing returns boolean\r\n        return BattleEnd.GetDataBoolean(\"is_win\") == false\r\n    endfunction\r\n    \r\n    private function action takes nothing returns nothing\r\n    \tlocal unit caster = BattleEnd.GetDataUnit(\"caster\")\r\n    \t\r\n        call SetHeroLevel(caster, GetHeroLevel(caster) + LEVEL_BONUS, false)\r\n        \r\n        set caster = null\r\n    endfunction\r\n\r\n    private function init takes nothing returns nothing\r\n        call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition, null )\r\n    endfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}