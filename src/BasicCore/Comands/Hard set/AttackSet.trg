{
  "Id": 50332160,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_AttackSet_Conditions takes nothing returns boolean\r\n    return GetTriggerPlayer() == udg_Host and SubString(GetEventPlayerChatString(), 0, 7) == \"-set at\" and not( udg_fightmod[0] ) and udg_Boss_LvL == 1 and udg_Heroes_Chanse > 0\r\nendfunction\r\n\r\nfunction Trig_AttackSet_Actions takes nothing returns nothing\r\n\tlocal integer r = S2I(SubString(GetEventPlayerChatString(), 8, 12))\r\n\tlocal real bonus = r / 100.\r\n\r\n\tset udg_BossChange = true\r\n\tcall EnemyPower_SetAtBonusAdditive(bonus)\r\n\r\n    call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 10, \"|cffffcc00Enemy attack power:|r \" + I2S( r ) + \"%.\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_AttackSet takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_AttackSet = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_AttackSet, Player(cyclA), \"-set at \", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_AttackSet, Condition( function Trig_AttackSet_Conditions ) )\r\n    call TriggerAddAction( gg_trg_AttackSet, function Trig_AttackSet_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}