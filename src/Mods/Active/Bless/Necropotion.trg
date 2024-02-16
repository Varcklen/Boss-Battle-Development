{
  "Id": 50332217,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Necropotion_Conditions takes nothing returns boolean\r\n    return IsUnitInGroup(GetDyingUnit(), udg_heroinfo) and not( udg_fightmod[3] ) and combat( GetDyingUnit(), false, 0 )\r\nendfunction\r\n\r\nfunction Trig_Necropotion_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    \r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 and udg_combatlogic[GetPlayerId( GetOwningPlayer( udg_hero[cyclA] ) ) + 1] and UnitInventoryCount(udg_hero[cyclA]) < 6 and GetDyingUnit() != udg_hero[cyclA] then\r\n            set bj_lastCreatedItem = CreateItem( udg_Database_Item_Potion[GetRandomInt(1, udg_Database_NumberItems[9])], GetUnitX( udg_hero[cyclA] ), GetUnitY(udg_hero[cyclA]))\r\n            call UnitAddItem( udg_hero[cyclA], bj_lastCreatedItem )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Necropotion takes nothing returns nothing\r\n    set gg_trg_Necropotion = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Necropotion )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Necropotion, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Necropotion, Condition( function Trig_Necropotion_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Necropotion, function Trig_Necropotion_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}