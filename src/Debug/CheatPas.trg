{
  "Id": 50332347,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "\r\n\r\nfunction Trig_CheatPas_Actions takes nothing returns nothing\r\n    local integer cyclA = 0\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    if GetPlayerName(Player(0)) == \"WorldEdit\" then\r\n        set udg_logic[0] = true\r\n        loop\r\n            exitwhen cyclA > 3\r\n            if GetPlayerSlotState( Player( cyclA ) ) == PLAYER_SLOT_STATE_PLAYING then\r\n                set udg_cheater = Player( cyclA )\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        call CheatEnable()\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_CheatPas takes nothing returns nothing\r\n    set gg_trg_CheatPas = CreateTrigger(  )\r\n    call TriggerRegisterTimerEvent(gg_trg_CheatPas, 0.1, false)\r\n    call TriggerAddAction( gg_trg_CheatPas, function Trig_CheatPas_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}