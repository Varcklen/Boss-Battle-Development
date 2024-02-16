{
  "Id": 50333058,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope DiscountCoupon initializer init\r\n\r\n    globals\r\n        private constant integer ID_ITEM = 'I0A3'\r\n        private constant integer GOLD_BONUS = 150\r\n    endglobals\r\n\r\n    function ItemSplit_Conditions takes nothing returns boolean\r\n        return IsHeroHasItem( Event_ItemSplit_Hero, ID_ITEM ) and GetItemType(Event_ItemSplit_Item) != ITEM_TYPE_POWERUP and GetItemType(Event_ItemSplit_Item) != ITEM_TYPE_PURCHASABLE\r\n    endfunction\r\n    \r\n    function ItemSplit takes nothing returns nothing\r\n        call moneyst( Event_ItemSplit_Hero, GOLD_BONUS )\r\n    endfunction\r\n\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger( \"Event_ItemSplit_Real\", function ItemSplit, function ItemSplit_Conditions )\r\n    endfunction\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}