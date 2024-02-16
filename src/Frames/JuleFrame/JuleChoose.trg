{
  "Id": 50332337,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_JuleChoose_Conditions takes nothing returns boolean\r\n    return not(udg_fightmod[0])\r\nendfunction\r\n\r\nfunction Trig_JuleChoose_Actions takes nothing returns nothing\r\n\tlocal player pl = GetTriggerPlayer()\r\n\r\n    if GetUnitTypeId(GetTriggerUnit()) == 'h01G' then\r\n        if GetLocalPlayer() == pl then\r\n            //call BlzFrameSetVisible( specback, false )\r\n            call BlzFrameSetVisible( modesback, false )\r\n            //call BlzFrameSetVisible( quartback, false )\r\n            call BlzFrameSetVisible( juleback, true )\r\n        endif\r\n    else\r\n        if GetLocalPlayer() == pl then\r\n            call BlzFrameSetVisible( juleback, false )\r\n        endif\r\n    endif\r\n\r\n\tset pl = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_JuleChoose takes nothing returns nothing\r\n    local integer i = 0\r\n    set gg_trg_JuleChoose = CreateTrigger()\r\n    loop\r\n        exitwhen i > 3\r\n        call TriggerRegisterPlayerSelectionEventBJ( gg_trg_JuleChoose, Player(i), true )\r\n        set i = i + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_JuleChoose, Condition( function Trig_JuleChoose_Conditions ) )\r\n    call TriggerAddAction( gg_trg_JuleChoose, function Trig_JuleChoose_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}