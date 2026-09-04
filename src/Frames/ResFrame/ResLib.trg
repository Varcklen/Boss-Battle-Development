{
  "Id": 50332314,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library ResLib requires Conditions\r\n\r\n\tfunction RessurectionPoints takes integer i, boolean l returns nothing\r\n\t    set udg_Heroes_Ressurect_Battle = udg_Heroes_Ressurect_Battle + i\r\n\t\r\n\t    if udg_Heroes_Ressurect_Battle < 0 then\r\n\t        set udg_Heroes_Ressurect_Battle = 0\r\n\t    endif\r\n\t    \r\n\t    if udg_fightmod[0] then\r\n\t        call BlzFrameSetVisible( resback, true )\r\n\t        call BlzFrameSetText( restext, I2S(udg_Heroes_Ressurect_Battle) )\r\n\t    endif\r\n\t\r\n\t    if l then\r\n\t        set udg_Heroes_Ressurect = udg_Heroes_Ressurect + i\r\n\t        if udg_Heroes_Ressurect < 0 then\r\n\t            set udg_Heroes_Ressurect = 0\r\n\t        endif\r\n\t        call Multiboard_MultiSetValue( udg_multi, 2, 2, I2S(udg_Heroes_Ressurect) )\r\n\t    endif\r\n\tendfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}