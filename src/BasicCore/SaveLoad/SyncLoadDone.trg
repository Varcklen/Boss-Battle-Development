{
  "Id": 50332145,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SyncLoadDone_Actions takes nothing returns nothing\r\n    local string prefix = BlzGetTriggerSyncPrefix()\r\n    local string value = BlzGetTriggerSyncData()\r\n    local integer i = GetPlayerId(GetTriggerPlayer()) + 1\r\n    \r\n    if prefix == \"myprefix\" then\r\n        set udg_LoadCode[i] = value\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SyncLoadDone takes nothing returns nothing\r\n    local integer i = 0\r\n    set gg_trg_SyncLoadDone = CreateTrigger(  )\r\n\r\n    loop\r\n        call BlzTriggerRegisterPlayerSyncEvent(gg_trg_SyncLoadDone, Player(i), \"myprefix\", false)\r\n        //call BlzTriggerRegisterPlayerSyncEvent(gg_trg_SyncLoadDone, Player(i), \"lvl\", false)\r\n        set i = i + 1\r\n        exitwhen i == 4\r\n    endloop\r\n    call TriggerAddAction(gg_trg_SyncLoadDone, function Trig_SyncLoadDone_Actions)\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}