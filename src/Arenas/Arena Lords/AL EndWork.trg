{
  "Id": 50333708,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope ArenaLordsWorkEnd\r\n\r\n    function Trig_AL_EndWork_Actions takes nothing returns nothing\r\n        set udg_fightmod[4] = false\r\n        call DisableTrigger( gg_trg_IA_TPBattle )\r\n        call OverlordArenaDeath_Disable()\r\n        call UnitAddAbility( udg_UNIT_DUMMY_BUFF, 'A03U' )\r\n\r\n\t\tcall ExtraArenaGeneral_RemovePortals()\r\n        call ExtraArenaGeneral_ReviveHeroes()\r\n        call FightEnd()\r\n        call SetNextBattleInfo()\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    function InitTrig_AL_EndWork takes nothing returns nothing\r\n        set gg_trg_AL_EndWork = CreateTrigger(  )\r\n        call TriggerAddAction( gg_trg_AL_EndWork, function Trig_AL_EndWork_Actions )\r\n    endfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}