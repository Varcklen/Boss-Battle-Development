{
  "Id": 50332161,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SpellSet_Conditions takes nothing returns boolean\r\n    return GetTriggerPlayer() == udg_Host and SubString(GetEventPlayerChatString(), 0, 7) == \"-set sp\" and not( udg_fightmod[0] ) and udg_Boss_LvL == 1 and udg_Heroes_Chanse > 0\r\nendfunction\r\n\r\nfunction Trig_SpellSet_Actions takes nothing returns nothing\r\n\tlocal real r = S2I(SubString(GetEventPlayerChatString(), 8, 12))\r\n\r\n\tset udg_BossChange = true\r\n    call SpellPower_SetBossSpellPower(r/100)\r\n\r\n    call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 10, \"|cffffcc00Enemy spell power:|r \" + I2S( R2I((SpellPower_GetBossSpellPower()*100)) ) + \"%.\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SpellSet takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_SpellSet = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_SpellSet, Player(cyclA), \"-set sp \", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_SpellSet, Condition( function Trig_SpellSet_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SpellSet, function Trig_SpellSet_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}