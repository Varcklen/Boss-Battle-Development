{
  "Id": 50332201,
  "Comment": "",
  "IsScript": false,
  "RunOnMapInit": false,
  "Script": "",
  "Events": [
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [],
        "value": "TriggerRegisterGameSavedEventBJ"
      }
    }
  ],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": [
    {
      "isEnabled": true,
      "function": {
        "ParamType": 1,
        "parameters": [
          {
            "ParamType": 1,
            "parameters": [],
            "value": "GetPlayersAll"
          },
          {
            "ParamType": 5,
            "value": "20.00"
          },
          {
            "ParamType": 5,
            "value": "|cffffcc00Warning!|r The map is not intended to be played after exiting a match. We recommend that you finish the game without loading the map. Otherwise, the map may not work correctly."
          }
        ],
        "value": "DisplayTimedTextToForce"
      }
    }
  ]
}