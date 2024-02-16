{
  "Id": 50333708,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope ArenaLordsWorkEnd\r\n\r\n    function Trig_AL_EndWork_Actions takes nothing returns nothing\r\n        local integer i = 1\r\n        local unit hero\r\n        local real locX\r\n        local real locY\r\n        \r\n        set udg_fightmod[4] = false\r\n        call DisableTrigger( gg_trg_IA_TPBattle )\r\n        call DisableTrigger( gg_trg_AL_End )\r\n        call UnitAddAbility( udg_UNIT_DUMMY_BUFF, 'A03U' )\r\n\r\n        loop\r\n            exitwhen i > PLAYERS_LIMIT\r\n            if GetPlayerSlotState(Player(i - 1)) == PLAYER_SLOT_STATE_PLAYING then\r\n                set hero = udg_hero[i]\r\n                set locX = GetLocationX( udg_point[i + 21])\r\n                set locY = GetLocationY( udg_point[i + 21])\r\n                \r\n                call ReviveHero( hero, locX, locY, true )\r\n                call SetUnitPosition( hero, locX, locY )\r\n                call SetUnitFacing( hero, 90 )\r\n                if GetLocalPlayer() == Player(i - 1) then\r\n                    call PanCameraToTimed(locX, locY, 0)\r\n                endif\r\n            endif\r\n            set i = i + 1\r\n        endloop\r\n        call FightEnd()\r\n        \r\n        set hero = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    function InitTrig_AL_EndWork takes nothing returns nothing\r\n        set gg_trg_AL_EndWork = CreateTrigger(  )\r\n        call TriggerAddAction( gg_trg_AL_EndWork, function Trig_AL_EndWork_Actions )\r\n    endfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}