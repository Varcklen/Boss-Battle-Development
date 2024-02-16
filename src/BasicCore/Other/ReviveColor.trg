{
  "Id": 50332197,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function ColorOwner takes unit u returns boolean\r\n    local boolean l = false\r\n    local integer i = 0\r\n    \r\n    loop\r\n        exitwhen i > 3\r\n        if GetOwningPlayer(u) == Player(i) then\r\n            set i = 3\r\n            set l = true\r\n        endif\r\n        set i = i + 1\r\n    endloop\r\n    \r\n    set u = null\r\n    return l\r\nendfunction\r\n\r\nfunction Trig_ReviveColor_Actions takes nothing returns nothing\r\n    if ColorOwner(GetRevivingUnit()) then\r\n        call SetUnitColor(GetRevivingUnit(), ConvertPlayerColor(udg_Player_Color_Int[GetPlayerId(GetOwningPlayer(GetRevivingUnit()))+1]-1))\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ReviveColor takes nothing returns nothing\r\n    set gg_trg_ReviveColor = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_ReviveColor, EVENT_PLAYER_HERO_REVIVE_FINISH )\r\n    call TriggerAddAction( gg_trg_ReviveColor, function Trig_ReviveColor_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}