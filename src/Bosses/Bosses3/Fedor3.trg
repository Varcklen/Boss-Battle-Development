{
  "Id": 50333460,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Fedor3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( GetDyingUnit() ) == 'h00C' and udg_fightmod[0]\r\nendfunction\r\n\r\nfunction Trig_Fedor3_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call SpawnCatapults( GetDyingUnit() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Fedor3 takes nothing returns nothing\r\n    set gg_trg_Fedor3 = CreateTrigger()\r\n    call DisableTrigger( gg_trg_Fedor3 )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Fedor3, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Fedor3, Condition( function Trig_Fedor3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Fedor3, function Trig_Fedor3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}