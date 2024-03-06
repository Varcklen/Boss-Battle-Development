{
  "Id": 50333399,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope TimerExpireWarning initializer init\r\n\r\n\tprivate function action takes nothing returns nothing\r\n\t    call DisplayTimedTextToForce( GetPlayersAll(), 10, \"|cffffcc00Warning!|r 20 seconds left before the battle starts!\" )\r\n\t    call StartSound(gg_snd_Warning)\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    local trigger trig = CreateTrigger(  )\r\n\t    call TriggerRegisterTimerExpireEvent( trig, OutOfCombatTimer_TimerWarning )\r\n\t    call TriggerAddAction( trig, function action )\r\n\tendfunction\r\n\r\nscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}