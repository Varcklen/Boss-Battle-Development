{
  "Id": 50333697,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_IA_EndWork_Actions takes nothing returns nothing\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    local integer cyclA = 1\r\n    \r\n    set udg_fightmod[2] = false\r\n    call DisableTrigger( gg_trg_IA_TPBattle )\r\n    call InfiniteArenaDeath_Disable()\r\n    set bj_livingPlayerUnitsTypeId = 'h00J'\r\n    call GroupEnumUnitsOfPlayer(g, Player( 10 ), filterLivingPlayerUnitsOfTypeId)\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        call RemoveUnit( u )\r\n        call GroupRemoveUnit(g,u)\r\n        set u = FirstOfGroup(g)\r\n    endloop\r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetPlayerSlotState(Player(cyclA - 1)) == PLAYER_SLOT_STATE_PLAYING then\r\n            call ReviveHeroLoc( udg_hero[cyclA], udg_point[cyclA + 21], true )\r\n            call SetUnitPositionLoc( udg_hero[cyclA], udg_point[cyclA + 21] )\r\n            call SetUnitFacing( udg_hero[cyclA], 90 )\r\n            if GetLocalPlayer() == Player(cyclA - 1) then\r\n                call PanCameraToTimed(GetLocationX( udg_point[cyclA + 21]), GetLocationY( udg_point[cyclA + 21]), 0.)\r\n            endif\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call FightEnd()\r\n    call SetNextBattleInfo()\r\n    \r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_IA_EndWork takes nothing returns nothing\r\n    set gg_trg_IA_EndWork = CreateTrigger(  )\r\n    call TriggerAddAction( gg_trg_IA_EndWork, function Trig_IA_EndWork_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}