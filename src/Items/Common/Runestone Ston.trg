{
  "Id": 50332513,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope RuneStoneSton initializer init\r\n\r\n    globals\r\n        private constant integer ID_ITEM = 'I00M'\r\n        private constant integer CHANCE = 10\r\n    endglobals\r\n\r\n    private function condition takes nothing returns boolean\r\n        return combat( GetSpellAbilityUnit(), false, 0 ) and ExtraArenaGeneral_IsPvPActive() == false and LuckChance( GetSpellAbilityUnit(), CHANCE )\r\n    endfunction\r\n\r\n    private function action takes nothing returns nothing\r\n        call ExtraArenaGeneral_CreateRunes()\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call RegisterDuplicatableItemType(ID_ITEM, EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )\r\n    endfunction\r\n\r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}