{
  "Id": 50333324,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Corrupted_EntQVision_Actions takes nothing returns nothing\r\n    if GetUnitAbilityLevel(GetTriggerUnit(), 'A0OE') > 0 and GetTriggerPlayer() == GetOwningPlayer(GetTriggerUnit()) then\r\n        if GetLocalPlayer() == GetTriggerPlayer() then\r\n            call BlzFrameSetVisible( entQBackdrop, true )\r\n            call BlzFrameSetText( entQText, I2S(LoadInteger( udg_hash, GetHandleId( GetTriggerUnit() ), StringHash( \"entqch\" ) )) )\r\n        endif\r\n    else\r\n        if GetLocalPlayer() == GetTriggerPlayer() then\r\n            call BlzFrameSetVisible( entQBackdrop, false )\r\n        endif\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Corrupted_EntQVision takes nothing returns nothing\r\n    local integer i = 0\r\n    set gg_trg_Corrupted_EntQVision = CreateTrigger()\r\n    loop\r\n        exitwhen i > 3\r\n        call TriggerRegisterPlayerSelectionEventBJ( gg_trg_Corrupted_EntQVision, Player(i), true )\r\n        set i = i + 1\r\n    endloop\r\n    call TriggerAddAction( gg_trg_Corrupted_EntQVision, function Trig_Corrupted_EntQVision_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}