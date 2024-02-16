{
  "Id": 50332355,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cheattpboss_Actions takes nothing returns nothing\r\n    if GetTriggerPlayer() == udg_cheater then\r\n        set udg_Player_Readiness = udg_Heroes_Amount\r\n        call TriggerExecute( gg_trg_StartFight )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cheattpboss takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cheattpboss = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Cheattpboss )\r\n    loop\r\n        exitwhen cyclA > 3\r\n            call TriggerRegisterPlayerChatEvent( gg_trg_Cheattpboss, Player(cyclA), \"-tpboss\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Cheattpboss, function Trig_Cheattpboss_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}