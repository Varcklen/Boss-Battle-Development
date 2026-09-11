{
  "Id": 50332264,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_WormDeath_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetDyingUnit()) == 'n043'\r\nendfunction\r\n\r\nfunction Trig_WormDeath_Actions takes nothing returns nothing\r\n    call CreateItem( 'III4', GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_WormDeath takes nothing returns nothing\r\n    set gg_trg_WormDeath = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_WormDeath, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_WormDeath, Condition( function Trig_WormDeath_Conditions ) )\r\n    call TriggerAddAction( gg_trg_WormDeath, function Trig_WormDeath_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}