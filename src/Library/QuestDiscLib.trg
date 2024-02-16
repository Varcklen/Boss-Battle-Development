{
  "Id": 50332070,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library QuestDiscLib requires TextLib, ChangeToolLib\r\n\r\n    function QuestDiscription takes unit u, integer i, integer k, integer km returns nothing\r\n        local item it = GetItemOfTypeFromUnitBJ(u, i)\r\n        local string s = I2S(k)\r\n        local string sm = I2S(km)\r\n        \r\n        call textst( \"|c00ffffff \" + s + \"/\" + sm, u, 64, GetRandomReal( 45, 135 ), 8, 1.5 )\r\n        call BlzSetItemExtendedTooltip( it, words( u, BlzGetItemDescription(it), \"|cFF959697(\", \")|r\", s + \"/\" + sm ) ) // sadtwig\r\n        //call BlzSetItemIconPath( it, words( u, BlzGetItemDescription(it), \"|cFF959697(\", \")|r\", s + \"/\" + sm ) )\r\n        set it = null\r\n        set u = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}