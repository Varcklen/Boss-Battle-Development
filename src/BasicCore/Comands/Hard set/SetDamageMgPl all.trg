{
  "Id": 50332167,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SetDamageMgPl_all_Conditions takes nothing returns boolean\r\n    return GetTriggerPlayer() == udg_Host and SubString(GetEventPlayerChatString(), 0, 15) == \"-set dmg mg all\" and not( udg_fightmod[0] ) and udg_Boss_LvL == 1 and udg_Heroes_Chanse > 0\r\nendfunction\r\n\r\nfunction Trig_SetDamageMgPl_all_Actions takes nothing returns nothing\r\n    \tlocal integer i = GetPlayerId( GetTriggerPlayer() ) + 1\r\n\tlocal real r = S2I(SubString(GetEventPlayerChatString(), 16, 21)) \r\n\tlocal integer cyclA = 1\r\n\r\n\tset udg_BossChange = true\r\n\tloop\r\n\t\texitwhen cyclA > 4\r\n    \t\tset udg_BossDamageMagical[cyclA] = (r/100)-1\r\n\t\tif udg_BossDamageMagical[cyclA] < -0.8 then\r\n\t\t\tset udg_BossDamageMagical[cyclA] = -0.8\r\n\t\telseif udg_BossDamageMagical[cyclA] > 9 then\r\n\t\t\tset udg_BossDamageMagical[cyclA] = 9\r\n\t\tendif\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\n        call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 10, \"|cffffcc00ALL PLAYERS. Magical damage:|r \" + I2S( R2I(r) ) + \"%.\" ) \r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SetDamageMgPl_all takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_SetDamageMgPl_all = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_SetDamageMgPl_all, Player(cyclA), \"-set dmg mg all\", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_SetDamageMgPl_all, Condition( function Trig_SetDamageMgPl_all_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SetDamageMgPl_all, function Trig_SetDamageMgPl_all_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}