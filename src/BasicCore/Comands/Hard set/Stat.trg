{
  "Id": 50332158,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Stat_Conditions takes nothing returns boolean\r\n    return not( udg_fightmod[0] )\r\nendfunction\r\n\r\nfunction Trig_Stat_Actions takes nothing returns nothing\r\n    local integer k = GetPlayerId(GetTriggerPlayer()) + 1\r\n\r\n\tif udg_BossChange then\r\n    \t\tcall DisplayTimedTextToForce( GetForceOfPlayer(GetTriggerPlayer()), 10, \"CHANGED\" )\r\n\tendif\r\n    \tcall DisplayTimedTextToForce( GetForceOfPlayer(GetTriggerPlayer()), 10, \"|cffffcc00Enemy health:|r \" + I2S( R2I((udg_BossHP*100)) ) + \"%.\" )\r\n        call DisplayTimedTextToForce( GetForceOfPlayer(GetTriggerPlayer()), 10, \"|cffffcc00Enemy attack power:|r \" + I2S( R2I((udg_BossAT*100)) ) + \"%.\" )\r\n        call DisplayTimedTextToForce( GetForceOfPlayer(GetTriggerPlayer()), 10, \"|cffffcc00Enemy spell power:|r \" + I2S( R2I((SpellPower_GetBossSpellPower()*100)) ) + \"%.\" )\r\n        call DisplayTimedTextToForce( GetForceOfPlayer(GetTriggerPlayer()), 10, \"|cffffcc00Health and mana healing:|r \" + I2S( R2I((udg_BossHeal[k]*100)) ) + \"%.\" )\r\n        call DisplayTimedTextToForce( GetForceOfPlayer(GetTriggerPlayer()), 10, \"|cffffcc00Physical damage:|r \" + I2S( R2I(((udg_BossDamagePhysical[k]+1)*100)) ) + \"%.\" )\r\n        call DisplayTimedTextToForce( GetForceOfPlayer(GetTriggerPlayer()), 10, \"|cffffcc00Magical damage:|r \" + I2S( R2I(((udg_BossDamageMagical[k]+1)*100)) ) + \"%.\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Stat takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Stat = CreateTrigger()\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Stat, Player(cyclA), \"-stat\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_Stat, Condition( function Trig_Stat_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Stat, function Trig_Stat_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}