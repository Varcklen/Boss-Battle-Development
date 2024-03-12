{
  "Id": 50333396,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MinionsTeleportation_Conditions takes nothing returns boolean\r\n    return udg_fightmod[1] and not(udg_fightmod[3]) and not( RectContainsUnit(udg_Boss_Rect, GetEnteringUnit()) ) and not( IsUnitType(GetEnteringUnit(), UNIT_TYPE_HERO) ) and GetOwningPlayer(GetEnteringUnit()) != Player(4) and GetUnitTypeId(GetEnteringUnit()) != 'h009' and GetUnitTypeId(GetEnteringUnit()) != 'h01F'\r\nendfunction\r\n\r\nfunction Trig_MinionsTeleportation_Actions takes nothing returns nothing\r\n\tlocal unit target = DeathSystem_GetRandomAliveHero()\r\n    call SetUnitPositionLoc( GetEnteringUnit(), GetUnitLoc(target) )\r\n    \r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MinionsTeleportation takes nothing returns nothing\r\n    set gg_trg_MinionsTeleportation = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_MinionsTeleportation )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_MinionsTeleportation, GetWorldBounds() )\r\n    call TriggerAddCondition( gg_trg_MinionsTeleportation, Condition( function Trig_MinionsTeleportation_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MinionsTeleportation, function Trig_MinionsTeleportation_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}