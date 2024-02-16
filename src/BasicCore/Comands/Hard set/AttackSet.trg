{
  "Id": 50332160,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_AttackSet_Conditions takes nothing returns boolean\r\n    return GetTriggerPlayer() == udg_Host and SubString(GetEventPlayerChatString(), 0, 7) == \"-set at\" and not( udg_fightmod[0] ) and udg_Boss_LvL == 1 and udg_Heroes_Chanse > 0\r\nendfunction\r\n\r\nfunction Trig_AttackSet_Actions takes nothing returns nothing\r\n\tlocal real r = S2I(SubString(GetEventPlayerChatString(), 8, 12))\r\n\r\n\tset udg_BossChange = true\r\n    \tset udg_BossAT = r/100\r\n\r\n\tif udg_BossAT < 0.2 then\r\n\t\tset udg_BossHP = 0.2\r\n\telseif udg_BossAT > 10 then\r\n\t\tset udg_BossAT = 10\r\n\tendif\r\n        call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 10, \"|cffffcc00Enemy attack power:|r \" + I2S( R2I((udg_BossAT*100)) ) + \"%.\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_AttackSet takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_AttackSet = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_AttackSet, Player(cyclA), \"-set at \", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_AttackSet, Condition( function Trig_AttackSet_Conditions ) )\r\n    call TriggerAddAction( gg_trg_AttackSet, function Trig_AttackSet_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}