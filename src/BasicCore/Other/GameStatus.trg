{
  "Id": 50332191,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant integer GAME_STATUS_OFFLINE = 0\r\n    constant integer GAME_STATUS_ONLINE = 1\r\n    constant integer GAME_STATUS_REPLAY = 2\r\nendglobals\r\n\r\nfunction Trig_GameStatus_Actions takes nothing returns nothing\r\n    local integer i\r\n\r\n    // Initialize\r\n    \r\n    // Find a playing player. Its Just Works\r\n    set i = 1\r\n    loop\r\n        exitwhen i > 12\r\n        set udg_GameStatus_TempPlayer = Player(i - 1)\r\n        if GetPlayerController(udg_GameStatus_TempPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(udg_GameStatus_TempPlayer) == PLAYER_SLOT_STATE_PLAYING then\r\n            set i = 99\r\n        endif\r\n        set i = i + 1\r\n    endloop\r\n    // Find out the game status\r\n    call CreateNUnitsAtLoc( 1, 'hfoo', udg_GameStatus_TempPlayer, GetPlayerStartLocationLoc(udg_GameStatus_TempPlayer), bj_UNIT_FACING )\r\n    call SelectUnitForPlayerSingle( bj_lastCreatedUnit, udg_GameStatus_TempPlayer )\r\n    if IsUnitSelected(bj_lastCreatedUnit, udg_GameStatus_TempPlayer) then\r\n        if ReloadGameCachesFromDisk() then\r\n            set udg_GameStatus = GAME_STATUS_OFFLINE\r\n        else\r\n            //С этим стоит пользоватся осторожно. Может сломать реплеи\r\n            set udg_GameStatus = GAME_STATUS_REPLAY\r\n        endif\r\n    else\r\n        set udg_GameStatus = GAME_STATUS_ONLINE\r\n    endif\r\n    call RemoveUnit( bj_lastCreatedUnit )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_GameStatus takes nothing returns nothing\r\n    set gg_trg_GameStatus = CreateTrigger(  )\r\n    call TriggerRegisterTimerEventSingle( gg_trg_GameStatus, 0.00 )\r\n    call TriggerAddAction( gg_trg_GameStatus, function Trig_GameStatus_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}