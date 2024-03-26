{
  "Id": 50332143,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Tab_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId( GetTriggerPlayer() ) + 1\r\n\r\n    if GetLocalPlayer() == GetTriggerPlayer() then\r\n        if udg_combatlogic[i] and udg_Guild[i] != 0 and udg_Guild[i] != 2 and udg_Guild[i] != 6 and not(udg_GuildDone[i]) then\r\n            if BlzFrameIsVisible( gqfone ) then\r\n                call BlzFrameSetVisible(gqfone, false)\r\n            else\r\n                call BlzFrameSetVisible(gqfone, true)\r\n            endif\r\n        endif\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Tab takes nothing returns nothing\r\n    local integer i = 0\r\n    set gg_trg_Tab = CreateTrigger()\r\n    loop\r\n        exitwhen i > 3\r\n        call BlzTriggerRegisterPlayerKeyEvent( gg_trg_Tab, Player(i), OSKEY_TAB, 0, false )\r\n        set i = i + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Tab, function Trig_Tab_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}