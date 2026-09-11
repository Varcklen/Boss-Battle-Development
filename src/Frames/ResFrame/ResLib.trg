{
  "Id": 50332314,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library ResLib initializer init requires Conditions\r\n\r\n\tfunction RessurectionPoints takes integer valueToAdd, boolean isPermanent returns nothing\r\n\t    set udg_Heroes_Ressurect_Battle = udg_Heroes_Ressurect_Battle + valueToAdd\r\n\t\r\n\t    if udg_Heroes_Ressurect_Battle < 0 then\r\n\t        set udg_Heroes_Ressurect_Battle = 0\r\n\t    endif\r\n\t    \r\n\t    if udg_fightmod[0] and udg_Heroes_Ressurect_Battle > 0 then\r\n\t        call BlzFrameSetVisible( resback, true )\r\n\t        call BlzFrameSetText( restext, I2S(udg_Heroes_Ressurect_Battle) )\r\n\t    endif\r\n\t\r\n\t    if isPermanent then\r\n\t        set udg_Heroes_Ressurect = udg_Heroes_Ressurect + valueToAdd\r\n\t        if udg_Heroes_Ressurect < 0 then\r\n\t            set udg_Heroes_Ressurect = 0\r\n\t        endif\r\n\t        call Multiboard_MultiSetValue( 2, 2, I2S(udg_Heroes_Ressurect) )\r\n\t    endif\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n    private function OnBattleStart takes nothing returns nothing\r\n\t\tcall RessurectionPoints( -100, false )\r\n        if udg_Heroes_Ressurect > 0 then\r\n            call RessurectionPoints( udg_Heroes_Ressurect, false )\r\n            call BlzFrameSetVisible( resback, true )\r\n            call BlzFrameSetText( restext, I2S(udg_Heroes_Ressurect_Battle) )\r\n        endif\r\n\tendfunction\r\n\r\n\t//===========================================================================\r\n    private function init takes nothing returns nothing\r\n\t\tcall BattleStartGlobal.AddListener(function OnBattleStart, null)\r\n\tendfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}