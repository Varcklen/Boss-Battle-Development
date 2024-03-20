{
  "Id": 50333058,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope DiscountCoupon initializer init\r\n\r\n    globals\r\n        private constant integer ITEM_ID = 'I0A3'\r\n        private constant integer GOLD_BONUS = 150\r\n    endglobals\r\n\r\n    private function condition takes nothing returns boolean\r\n        return GetItemType(BeforeItemSplit.GetDataItem(\"item_used\")) != ITEM_TYPE_POWERUP and GetItemType(BeforeItemSplit.GetDataItem(\"item_used\")) != ITEM_TYPE_PURCHASABLE\r\n    endfunction\r\n    \r\n    private function action takes nothing returns nothing\r\n    \tlocal unit caster = BeforeItemSplit.GetDataUnit(\"caster\")\r\n    \t\r\n        call moneyst( caster, GOLD_BONUS )\r\n        \r\n        set caster = null\r\n    endfunction\r\n\r\n    private function init takes nothing returns nothing\r\n    \tcall RegisterDuplicatableItemTypeCustom( ITEM_ID, BeforeItemSplit, function action, function condition, null )\r\n        //call CreateEventTrigger( \"Event_ItemSplit_Real\", function ItemSplit, function ItemSplit_Conditions )\r\n    endfunction\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}