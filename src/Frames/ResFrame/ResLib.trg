{
  "Id": 50332314,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library ResLib\r\n\r\nfunction RessurectionPoints takes integer i, boolean l returns nothing\r\n    set udg_Heroes_Ressurect_Battle = udg_Heroes_Ressurect_Battle + i\r\n\r\n    if udg_Heroes_Ressurect_Battle < 0 then\r\n        set udg_Heroes_Ressurect_Battle = 0\r\n    endif\r\n    \r\n    if udg_fightmod[0] then\r\n        call BlzFrameSetVisible( resback, true )\r\n        call BlzFrameSetText( restext, I2S(udg_Heroes_Ressurect_Battle) )\r\n    endif\r\n\r\n    if l then\r\n        set udg_Heroes_Ressurect = udg_Heroes_Ressurect + i\r\n        if udg_Heroes_Ressurect < 0 then\r\n            set udg_Heroes_Ressurect = 0\r\n        endif\r\n        call MultiSetValue( udg_multi, 2, 2, I2S(udg_Heroes_Ressurect) )\r\n    endif\r\nendfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}