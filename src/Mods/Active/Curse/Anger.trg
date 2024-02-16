{
  "Id": 50332234,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Anger_Conditions takes nothing returns boolean\r\n    return udg_modbad[26]\r\nendfunction\r\n\r\nfunction Trig_Anger_Actions takes nothing returns nothing\r\n    call UnitAddAbility(UNIT_BUFF, 'A0KH')\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Anger takes nothing returns nothing\r\n    set gg_trg_Anger = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Anger, \"Event_Mode_Awake_Real\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Anger, Condition( function Trig_Anger_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Anger, function Trig_Anger_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}