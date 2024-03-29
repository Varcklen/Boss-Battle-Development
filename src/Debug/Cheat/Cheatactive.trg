{
  "Id": 50332357,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheatactive_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetTriggerPlayer()) + 1\r\n    \r\n    if GetTriggerPlayer() == CheatSystem_GetCheater()  then\r\n        call coldstop( udg_hero[1] )\r\n        call coldstop( udg_hero[2] )\r\n        call coldstop( udg_hero[3] )\r\n        call coldstop( udg_hero[4] )\r\n        call SetUnitState( udg_hero[i], UNIT_STATE_MANA, GetUnitState(udg_hero[i], UNIT_STATE_MAX_MANA) )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheatactive takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheatactive = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n            call TriggerRegisterPlayerEvent( gg_trg_Cheatactive, Player(cyclA), EVENT_PLAYER_ARROW_UP_DOWN)\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Cheatactive, function Trig_Cheatactive_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}