{
  "Id": 50332255,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Teleportation_Conditions takes nothing returns boolean\r\n    return IsUnitInGroup(GetEnteringUnit(), udg_heroinfo)\r\nendfunction\r\n\r\nfunction Trig_Teleportation_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetOwningPlayer(GetEnteringUnit())) + 1\r\n\r\n    call SetUnitPosition(GetEnteringUnit(), GetLocationX(udg_point[i + 21]), GetLocationY(udg_point[i + 21]) )\r\n    call SetUnitFacing(GetEnteringUnit(), 90 )\r\n    call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetEnteringUnit()), udg_point[i + 21], 0.00 )\r\n    call DestroyEffect( AddSpecialEffect(\"Void Teleport Caster.mdx\", GetLocationX(udg_point[i + 21]), GetLocationY(udg_point[i + 21]) ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Teleportation takes nothing returns nothing\r\n    set gg_trg_Teleportation = CreateTrigger(  )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_Teleportation, gg_rct_Teleportation )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_Teleportation, gg_rct_Teleportation2 )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_Teleportation, gg_rct_Teleportation3 )\r\n    call TriggerAddCondition( gg_trg_Teleportation, Condition( function Trig_Teleportation_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Teleportation, function Trig_Teleportation_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}