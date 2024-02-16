{
  "Id": 50332256,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_HomeLeave1_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetOwningPlayer(GetEnteringUnit())) + 1\r\n    \r\n    if IsUnitInGroup(GetEnteringUnit(), udg_heroinfo) then\r\n        call SetUnitPosition(GetEnteringUnit(), GetRectCenterX(gg_rct_HeroTp), GetRectCenterY(gg_rct_HeroTp) )\r\n        call SetUnitFacing(GetEnteringUnit(), 270 )\r\n        call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetEnteringUnit()), GetRectCenter(gg_rct_HeroTp), 0. )\r\n        call DestroyEffect( AddSpecialEffect(\"Void Teleport Caster.mdx\", GetRectCenterX(gg_rct_HeroTp), GetRectCenterY(gg_rct_HeroTp) ) )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_HomeLeave1 takes nothing returns nothing\r\n    set gg_trg_HomeLeave1 = CreateTrigger()\r\n    call TriggerRegisterEnterRectSimple( gg_trg_HomeLeave1, gg_rct_ChoiseLeave1 )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_HomeLeave1, gg_rct_ChoiseLeave2 )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_HomeLeave1, gg_rct_ChoiseLeave3 )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_HomeLeave1, gg_rct_ChoiseLeave4 )\r\n    call TriggerAddAction( gg_trg_HomeLeave1, function Trig_HomeLeave1_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}