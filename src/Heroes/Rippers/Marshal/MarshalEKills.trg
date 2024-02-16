{
  "Id": 50333077,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MarshalEKills_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel( Event_Hero_Kill_Unit, 'A0F7') > 0 and GetUnitAbilityLevel( Event_Hero_Kill_Unit, 'A0G0') > 0\r\nendfunction\r\n\r\nfunction Trig_MarshalEKills_Actions takes nothing returns nothing\r\n    call UnitRemoveAbility(Event_Hero_Kill_Unit, 'A0G0')\r\n    call UnitRemoveAbility(Event_Hero_Kill_Unit, 'B06B')\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MarshalEKills takes nothing returns nothing\r\n    set gg_trg_MarshalEKills = CreateTrigger(  )\r\n     call TriggerRegisterVariableEvent( gg_trg_MarshalEKills, \"Event_Hero_Kill_Real\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_MarshalEKills, Condition( function Trig_MarshalEKills_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MarshalEKills, function Trig_MarshalEKills_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}