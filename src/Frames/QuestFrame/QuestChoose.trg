{
  "Id": 50332323,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_QuestChoose_Conditions takes nothing returns boolean\r\n    return not(udg_fightmod[0])\r\nendfunction\r\n\r\nfunction Trig_QuestChoose_Actions takes nothing returns nothing\r\n    local player p = GetTriggerPlayer()\r\n\r\n    if GetUnitTypeId(GetTriggerUnit()) == 'h00P' then\r\n        if udg_QuestLimit[GetPlayerId( p ) + 1] then\r\n            call DisplayTimedTextToPlayer( p, 0, 0, 5, \"You have already chosen the quest. You can't take another one.\")\r\n        else\r\n            if GetLocalPlayer() == p then\r\n                call BlzFrameSetVisible( modesback, false )\r\n                call BlzFrameSetVisible( quartback, true )\r\n            endif\r\n        endif\r\n    else\r\n        if GetLocalPlayer() == p then\r\n            call BlzFrameSetVisible( quartback, false )\r\n        endif\r\n    endif\r\n    \r\n    set p = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_QuestChoose takes nothing returns nothing\r\n    local integer i = 0\r\n    set gg_trg_QuestChoose = CreateTrigger()\r\n    loop\r\n        exitwhen i > 3\r\n        call TriggerRegisterPlayerSelectionEventBJ( gg_trg_QuestChoose, Player(i), true )\r\n        set i = i + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_QuestChoose, Condition( function Trig_QuestChoose_Conditions ) )\r\n    call TriggerAddAction( gg_trg_QuestChoose, function Trig_QuestChoose_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}