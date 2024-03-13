{
  "Id": 50333393,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_StartFight_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A016'\r\nendfunction\r\n\r\nfunction IsNextBattleInfiniteArena takes nothing returns boolean\r\n\treturn udg_logic[71] and ( udg_Boss_LvL == 4 or udg_Boss_LvL == 7 or udg_Boss_LvL == 9 ) and not( udg_logic[33] ) and (not( udg_logic[101] ) or (udg_ArenaLim[0] == 0 and udg_logic[101]))\r\nendfunction\r\n\r\nfunction IsNextBattleOverlordArena takes nothing returns boolean\r\n\treturn udg_logic[71] and ( udg_Boss_LvL == 5 or udg_Boss_LvL == 10 ) and not( udg_logic[31] ) and (not( udg_logic[101] ) or (udg_ArenaLim[1] == 0 and udg_logic[101]))\r\nendfunction\r\n\r\nfunction Trig_StartFight_Actions takes nothing returns nothing\r\n\tlocal integer cyclA = 0\r\n\t\r\n    if IsNextBattleInfiniteArena() then\r\n        call Between( \"start_IA\" )\r\n    elseif IsNextBattleOverlordArena() then\r\n        call Between( \"start_AL\" )\r\n    elseif not( udg_fightmod[1] ) then\r\n        call Between( \"start_boss\" )\r\n    endif\r\n    \r\n    set udg_HeroesDiedBattle = 0\r\n    loop\r\n    \texitwhen cyclA > 3\r\n    \tset udg_EternalHarvestTriggered[cyclA] = false\r\n    \tset cyclA = cyclA + 1\r\n    endloop\r\n        \r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_StartFight takes nothing returns nothing\r\n    set gg_trg_StartFight = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_StartFight, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_StartFight, Condition( function Trig_StartFight_Conditions ) )\r\n    call TriggerAddAction( gg_trg_StartFight, function Trig_StartFight_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}