{
  "Id": 50332159,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_HealthSet_Conditions takes nothing returns boolean\r\n    return GetTriggerPlayer() == udg_Host and SubString(GetEventPlayerChatString(), 0, 7) == \"-set hp\" and not( udg_fightmod[0] ) and udg_Boss_LvL == 1 and udg_Heroes_Chanse > 0\r\nendfunction\r\n\r\nfunction Trig_HealthSet_Actions takes nothing returns nothing\r\n\tlocal real r = S2I(SubString(GetEventPlayerChatString(), 8, 12))\r\n\r\n\tset udg_BossChange = true\r\n    \tset udg_BossHP = r/100\r\n\r\n\tif udg_BossHP < 0.2 then\r\n\t\tset udg_BossHP = 0.2\r\n\telseif udg_BossHP > 10 then\r\n\t\tset udg_BossHP = 10\r\n\tendif\r\n        call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 10, \"|cffffcc00Enemy health:|r \" + I2S( R2I((udg_BossHP*100)) ) + \"%.\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_HealthSet takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_HealthSet = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_HealthSet, Player(cyclA), \"-set hp \", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_HealthSet, Condition( function Trig_HealthSet_Conditions ) )\r\n    call TriggerAddAction( gg_trg_HealthSet, function Trig_HealthSet_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}