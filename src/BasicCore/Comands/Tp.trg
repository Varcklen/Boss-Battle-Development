{
  "Id": 50332177,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Tp_Conditions takes nothing returns boolean\r\n    return not( udg_fightmod[0] )\r\nendfunction\r\n\r\nfunction Trig_Tp_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetTriggerPlayer()) + 1\r\n    local unit u = udg_hero[i]\r\n\r\n    if u != null then\r\n        call SetUnitPosition( u, GetLocationX(udg_point[i + 21]), GetLocationY(udg_point[i + 21]) )\r\n        call SetUnitFacing( u, 90 )\r\n        call PanCameraToTimedLocForPlayer( GetOwningPlayer(u), udg_point[i + 21], 0.00 )\r\n        call DestroyEffect( AddSpecialEffect(\"Void Teleport Caster.mdx\", GetLocationX(udg_point[i + 21]), GetLocationY(udg_point[i + 21]) ) )\r\n    endif\r\n    \r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Tp takes nothing returns nothing\r\n    local integer cyclA = 0\r\n    set gg_trg_Tp = CreateTrigger()\r\n    loop\r\n        exitwhen cyclA > 3\r\n        call TriggerRegisterPlayerChatEvent( gg_trg_Tp, Player(cyclA), \"-tp\", true )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call TriggerAddCondition( gg_trg_Tp, Condition( function Trig_Tp_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Tp, function Trig_Tp_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}