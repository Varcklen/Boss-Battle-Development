{
  "Id": 50332142,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Esc_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId( GetTriggerPlayer() ) + 1\r\n\r\n    if GetLocalPlayer() == GetTriggerPlayer() then\r\n        if BlzFrameIsVisible( quartback ) then\r\n\t\t\tcall BlzFrameSetVisible(quartback, false)\r\n        elseif udg_LogicModes and udg_hero[i] != null then\r\n            if BlzFrameIsVisible( modesback ) then\r\n                call BlzFrameSetVisible(modesback, false)\r\n            else\r\n                call BlzFrameSetVisible(modesback, true)\r\n            endif\r\n\t\tendif\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Esc takes nothing returns nothing\r\n    local integer i = 0\r\n    set gg_trg_Esc = CreateTrigger()\r\n    loop\r\n        exitwhen i > 3\r\n        call BlzTriggerRegisterPlayerKeyEvent( gg_trg_Esc, Player(i), OSKEY_ESCAPE, 0, false )\r\n        set i = i + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Esc, function Trig_Esc_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}