{
  "Id": 50333697,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_IA_EndWork_Actions takes nothing returns nothing\r\n    set udg_fightmod[2] = false\r\n    call DisableTrigger( gg_trg_IA_TPBattle )\r\n    call InfiniteArenaDeath_Disable()\r\n    \r\n    call ExtraArenaGeneral_RemovePortals()\r\n    \r\n    call ExtraArenaGeneral_ReviveHeroes()\r\n    call FightEnd()\r\n    call SetNextBattleInfo()\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_IA_EndWork takes nothing returns nothing\r\n    set gg_trg_IA_EndWork = CreateTrigger(  )\r\n    call TriggerAddAction( gg_trg_IA_EndWork, function Trig_IA_EndWork_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}