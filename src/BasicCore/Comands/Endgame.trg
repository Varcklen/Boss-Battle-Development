{
  "Id": 50332179,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Endgame_Conditions takes nothing returns boolean\r\n    return not( udg_fightmod[0] ) and udg_logic[43]\r\nendfunction\r\n\r\nfunction Trig_Endgame_Actions takes nothing returns nothing\r\n    local integer v = IMinBJ(6, udg_HardNum+2)\r\n    local integer p\r\n    local integer i\r\n\r\n    call DisplayTimedTextToForce( GetPlayersAll(), 5.00, \"Endgame mode №\" +I2S(R2I(udg_Endgame)) + \" enabled.\" )\r\n\r\n    set udg_HardNum = v\r\n    set p = udg_DB_Hardest_On[udg_HardNum]\r\n    call IconFrame( \"HardMode\", BlzGetAbilityIcon(p), BlzGetAbilityTooltip(p, 0), BlzGetAbilityExtendedTooltip(p, 0) )\r\n    call EnableTrigger( gg_trg_HardModActive )\r\n\tcall RemoveUnit( udg_Portal ) \r\n    call StopMusic(false)\r\n    call PlayThematicMusic( \"music\" )\r\n\tset udg_Endgame = udg_Endgame + 2\r\n    call SpellPower_AddBossSpellPower(2)\r\n\tset udg_logic[43] = false\r\n\tset udg_Boss_LvL = 1\r\n\tset udg_Boss_Random = GetRandomInt( 1, 5 )\r\n\tset udg_Player_Readiness = udg_Heroes_Amount\r\n    call TriggerExecute( gg_trg_StartFight )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Endgame takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Endgame = CreateTrigger()\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Endgame, Player(cyclA), \"-endgame\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_Endgame, Condition( function Trig_Endgame_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Endgame, function Trig_Endgame_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}