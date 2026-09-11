{
  "Id": 50332265,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PotionDeath_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetDyingUnit()) == 'h01J'\r\nendfunction\r\n\r\nfunction Trig_PotionDeath_Actions takes nothing returns nothing\r\n    call CreateItem( udg_Database_Item_Potion[GetRandomInt(1, udg_Database_NumberItems[9])], GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ) )\r\nendfunction\r\n    \r\n\r\n//===========================================================================\r\nfunction InitTrig_PotionDeath takes nothing returns nothing\r\n    set gg_trg_PotionDeath = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PotionDeath, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_PotionDeath, Condition( function Trig_PotionDeath_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PotionDeath, function Trig_PotionDeath_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}