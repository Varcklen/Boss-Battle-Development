{
  "Id": 50332502,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PinataD_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetDyingUnit()) == 'h01Z'\r\nendfunction\r\n\r\nfunction Trig_PinataD_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    loop\r\n\texitwhen cyclA > 4\r\n\tif GetPlayerSlotState( Player( cyclA - 1 ) ) == PLAYER_SLOT_STATE_PLAYING then\r\n\t\tcall moneyst( udg_hero[cyclA], 100 )\r\n\t\tif GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 and UnitInventoryCount(udg_hero[cyclA]) < 6 then\r\n            call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageDeathCaster.mdl\", GetUnitX( udg_hero[cyclA] ), GetUnitY( udg_hero[cyclA] ) ) )\r\n\t\t    call ItemRandomizerAll( udg_hero[cyclA], 0 )\r\n\t\tendif\r\n\tendif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PinataD takes nothing returns nothing\r\n    set gg_trg_PinataD = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PinataD, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_PinataD, Condition( function Trig_PinataD_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PinataD, function Trig_PinataD_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}