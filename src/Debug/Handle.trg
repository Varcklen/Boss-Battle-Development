{
  "Id": 50332369,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": true,
  "Script": "globals\r\n    leaderboard HandleBoard = null\r\nendglobals\r\n\r\nfunction HandleCounter_Update takes nothing returns nothing\r\n   local integer i = 0\r\n   local integer id\r\n   local location array P\r\n   local real result=0\r\n   loop\r\n      exitwhen i >= 50\r\n      set i = i + 1\r\n      set P[i] = Location(0,0)\r\n      set id = GetHandleId(P[i])\r\n      set result = result + (id-0x100000)\r\n   endloop\r\n   set result = result/i-i/2\r\n   loop\r\n      call RemoveLocation(P[i])\r\n      set P[i] = null\r\n      exitwhen i <= 1\r\n      set i = i - 1\r\n   endloop\r\n   call LeaderboardSetItemValue(HandleBoard,0,R2I(result))\r\nendfunction\r\n\r\nfunction HandleCounter_Actions takes nothing returns nothing\r\n   set HandleBoard = CreateLeaderboard()\r\n   call LeaderboardSetLabel(HandleBoard, \"Handle Counter\")\r\n   call PlayerSetLeaderboard(GetLocalPlayer(),HandleBoard)\r\n   call LeaderboardDisplay(HandleBoard,true)\r\n   call LeaderboardAddItem(HandleBoard,\"Handles\",0,Player(0))\r\n   call LeaderboardSetSizeByItemCount(HandleBoard,1)\r\n   call HandleCounter_Update()\r\n   call TimerStart(GetExpiredTimer(),0.05,true,function HandleCounter_Update)\r\nendfunction\r\n\r\nfunction Trig_Handle_Actions takes nothing returns nothing\r\n    call TimerStart(CreateTimer(),0,false,function HandleCounter_Actions)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Handle takes nothing returns nothing\r\n    set gg_trg_Handle = CreateTrigger(  )\r\n    call TriggerAddAction( gg_trg_Handle, function Trig_Handle_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}