{
  "Id": 50332266,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_BoxDeath_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetDyingUnit()) == 'h022'\r\nendfunction\r\n\r\nfunction Trig_BoxDeath_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    \r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetPlayerSlotState(Player(cyclA - 1)) == PLAYER_SLOT_STATE_PLAYING then\r\n            call moneyst(udg_hero[cyclA], 75)\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n    \r\n\r\n//===========================================================================\r\nfunction InitTrig_BoxDeath takes nothing returns nothing\r\n    set gg_trg_BoxDeath = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_BoxDeath, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_BoxDeath, Condition( function Trig_BoxDeath_Conditions ) )\r\n    call TriggerAddAction( gg_trg_BoxDeath, function Trig_BoxDeath_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}