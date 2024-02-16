{
  "Id": 50332352,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheattp_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    \r\n    if GetTriggerPlayer() == udg_cheater then\r\n        loop\r\n            exitwhen cyclA > 4\r\n            if GetPlayerSlotState(Player(cyclA - 1)) == PLAYER_SLOT_STATE_PLAYING then\r\n                call ReviveHero( udg_hero[cyclA], GetRectCenterX(gg_rct_HeroTp), GetRectCenterY(gg_rct_HeroTp), true )\r\n                call SetUnitPosition( udg_hero[cyclA], GetRectCenterX(gg_rct_HeroTp), GetRectCenterY(gg_rct_HeroTp))\r\n                call SetUnitFacing( udg_hero[cyclA], 270 )\r\n                call PanCameraToTimedForPlayer( Player(cyclA - 1), GetRectCenterX(gg_rct_HeroTp), GetRectCenterY(gg_rct_HeroTp), 0 )\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheattp takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheattp = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Cheattp )\r\n    loop\r\n        exitwhen cyclA > 3\r\n            call TriggerRegisterPlayerChatEvent( gg_trg_Cheattp, Player(cyclA), \"-tpgo\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Cheattp, function Trig_Cheattp_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}