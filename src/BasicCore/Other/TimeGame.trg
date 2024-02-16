{
  "Id": 50332202,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_TimeGame_Actions takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    local integer cyclB\r\n    \r\n    set udg_Multiboard_Time[1] = udg_Multiboard_Time[1] + 1\r\n    if udg_Multiboard_Time[1] >= 60 then\r\n        set udg_Multiboard_Time[1] = 0\r\n        set udg_Multiboard_Time[2] = udg_Multiboard_Time[2] + 1\r\n    elseif udg_Multiboard_Time[2] >= 60 then\r\n        set udg_Multiboard_Time[1] = 0\r\n        set udg_Multiboard_Time[2] = 0\r\n        set udg_Multiboard_Time[3] = udg_Multiboard_Time[3] + 1\r\n    endif\r\n    call MultiboardSetTitleText( udg_multi, \"Statistics [\" + I2S(udg_Multiboard_Time[3]) + \":\" + I2S(udg_Multiboard_Time[2]) + \":\" + I2S(udg_Multiboard_Time[1]) + \"]\" )\r\n\r\n    loop\r\n        exitwhen cyclA > 3\r\n        if GetPlayerSlotState( Player( cyclA ) ) == PLAYER_SLOT_STATE_PLAYING then\r\n            set cyclB = 0\r\n            loop\r\n                exitwhen cyclB > 3\r\n                if Player( cyclA ) != Player( cyclB ) then\r\n                    call SetPlayerAlliance(Player( cyclA ), Player( cyclB ), ALLIANCE_SHARED_CONTROL, false )\r\n                endif\r\n                set cyclB = cyclB + 1\r\n            endloop\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_TimeGame takes nothing returns nothing\r\n    set gg_trg_TimeGame = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_TimeGame )\r\n    call TriggerRegisterTimerEvent( gg_trg_TimeGame, 1., true)\r\n    call TriggerAddAction( gg_trg_TimeGame, function Trig_TimeGame_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}