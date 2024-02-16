{
  "Id": 50332172,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cam_Conditions takes nothing returns boolean\r\n    return udg_hero[GetPlayerId(GetTriggerPlayer()) + 1] != null and SubString(GetEventPlayerChatString(), 0, 4) == \"-cam\"\r\nendfunction\r\n\r\nfunction Trig_Cam_Actions takes nothing returns nothing\r\n    local integer i\r\n    local real r = 1500\r\n    \r\n    if S2I(SubString(GetEventPlayerChatString(), 5, 6)) >= 1 and S2I(SubString(GetEventPlayerChatString(), 5, 6)) <= 5 then\r\n        set i = S2I(SubString(GetEventPlayerChatString(), 5, 6))\r\n        if i == 1 then\r\n            set r = 2000\r\n        elseif i == 2 then\r\n            set r = 2225\r\n        elseif i == 3 then\r\n            set r = 2500\r\n        elseif i == 4 then\r\n            set r = 3000\r\n        elseif i == 5 then\r\n            set r = 3500\r\n        endif\r\n        if GetLocalPlayer() == GetTriggerPlayer() then\r\n            call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, r, 0.25)\r\n        endif\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cam takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Cam = CreateTrigger(  )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Cam, Player(cyclA), \"-cam \", false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_Cam, Condition( function Trig_Cam_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Cam, function Trig_Cam_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}