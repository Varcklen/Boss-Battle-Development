{
  "Id": 50332062,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library Trigger\r\n\r\n    globals\r\n        private trigger trig = null\r\n    endglobals\r\n\r\n    function CreateEventTrigger takes string eventReal, code action, code condition returns trigger\r\n        set trig = CreateTrigger()\r\n        call TriggerRegisterVariableEvent( trig, eventReal, EQUAL, 1.00 )\r\n        if condition != null then\r\n            call TriggerAddCondition( trig, Condition( condition ) )\r\n        endif\r\n        if action != null then\r\n            call TriggerAddAction( trig, action )\r\n        endif\r\n        return trig\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}