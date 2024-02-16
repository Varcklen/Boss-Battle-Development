{
  "Id": 50332225,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Majestic_Mates_Conditions takes nothing returns boolean\r\n    return udg_modgood[36]\r\nendfunction\r\n\r\nfunction Trig_Majestic_Mates_Actions takes nothing returns nothing\r\n    call UnitAddAbility(UNIT_BUFF, 'A14G')\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Majestic_Mates takes nothing returns nothing\r\n    call CreateEventTrigger( \"Event_Mode_Awake_Real\", function Trig_Majestic_Mates_Actions, function Trig_Majestic_Mates_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}