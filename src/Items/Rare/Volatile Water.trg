{
  "Id": 50332698,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "\r\nfunction Trig_Volatile_Water_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(Event_ItemExchange_Item) == 'I0GD'\r\nendfunction\r\n\r\nfunction Trig_Volatile_Water_Actions takes nothing returns nothing\r\n    local unit hero = Event_ItemExchange_Hero\r\n\r\n    set Event_ItemExchange_Item = Inventory_ReplaceItemByNew(hero, Event_ItemExchange_Item, GetItemTypeId(Event_ItemExchange_OldItem))\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( hero ), GetUnitY( hero ) ) )\r\n    \r\n    set hero = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Volatile_Water takes nothing returns nothing\r\n    call CreateEventTrigger( \"Event_ItemExchange_Real\", function Trig_Volatile_Water_Actions, function Trig_Volatile_Water_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}