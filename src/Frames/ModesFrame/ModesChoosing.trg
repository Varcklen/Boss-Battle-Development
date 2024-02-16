{
  "Id": 50333055,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_ModesChoosing_Conditions takes nothing returns boolean\r\n    return udg_fightmod[0] == false\r\nendfunction\r\n\r\nfunction Trig_ModesChoosing_Actions takes nothing returns nothing\r\n    //МОЖЕТ ВЫЗВАТЬ DESYNC! НУЖНО ПРОТЕСТИРОВАТЬ!\r\n    if GetLocalPlayer() == GetTriggerPlayer() and BlzFrameIsVisible( modesback ) then\r\n        call BlzFrameSetVisible( modesback, false )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ModesChoosing takes nothing returns nothing\r\n    local integer i = 0\r\n    set gg_trg_ModesChoosing = CreateTrigger()\r\n    loop\r\n        exitwhen i > 3\r\n        call TriggerRegisterPlayerSelectionEventBJ( gg_trg_ModesChoosing, Player(i), true )\r\n        set i = i + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_ModesChoosing, Condition( function Trig_ModesChoosing_Conditions ) )\r\n    call TriggerAddAction( gg_trg_ModesChoosing, function Trig_ModesChoosing_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}