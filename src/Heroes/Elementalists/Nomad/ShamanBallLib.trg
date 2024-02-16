{
  "Id": 50333270,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library ShamanBallLib\r\n\r\n    function BallEnergy takes unit u, integer k returns nothing\r\n        local player p = GetOwningPlayer( u )\r\n        local integer i = GetPlayerId(p) + 1\r\n        local integer f\r\n\r\n        set udg_lightball[i] = udg_lightball[i] + k\r\n\r\n        if udg_lightball[i] < 0 then\r\n            set udg_lightball[i] = 0\r\n        elseif udg_lightball[i] >= 3 then\r\n            set udg_lightball[i] = 3\r\n        endif\r\n        set f = udg_lightball[i]\r\n\r\n        if BlzFrameIsVisible( shamanframe ) then\r\n            if GetLocalPlayer() == p then\r\n                if f == 0 then\r\n                    call BlzFrameSetVisible( spfframe[1], false )\r\n                    call BlzFrameSetVisible( spfframe[2], false )\r\n                    call BlzFrameSetVisible( spfframe[3], false )\r\n                elseif f == 1 then\r\n                    call BlzFrameSetVisible( spfframe[1], true )\r\n                    call BlzFrameSetVisible( spfframe[2], false )\r\n                    call BlzFrameSetVisible( spfframe[3], false )\r\n                elseif f == 2 then\r\n                    call BlzFrameSetVisible( spfframe[1], true )\r\n                    call BlzFrameSetVisible( spfframe[2], true )\r\n                    call BlzFrameSetVisible( spfframe[3], false )\r\n                elseif f == 3 then\r\n                    call BlzFrameSetVisible( spfframe[1], true )\r\n                    call BlzFrameSetVisible( spfframe[2], true )\r\n                    call BlzFrameSetVisible( spfframe[3], true )\r\n                endif\r\n            endif\r\n        endif\r\n\r\n        set u = null\r\n        set p = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}