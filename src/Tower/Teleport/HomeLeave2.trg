{
  "Id": 50332257,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_HomeLeave2_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetOwningPlayer(GetEnteringUnit())) + 1\r\n    \r\n    if IsUnitInGroup(GetEnteringUnit(), udg_heroinfo) and IsVictory then\r\n        call SetUnitPosition(GetEnteringUnit(), GetRectCenterX(gg_rct_HeroTp), GetRectCenterY(gg_rct_HeroTp) )\r\n        call SetUnitFacing(GetEnteringUnit(), 270 )\r\n        call PanCameraToTimedLocForPlayer( GetOwningPlayer(GetEnteringUnit()), GetRectCenter(gg_rct_HeroTp), 0. )\r\n        call DestroyEffect( AddSpecialEffect(\"Void Teleport Caster.mdx\", GetRectCenterX(gg_rct_HeroTp), GetRectCenterY(gg_rct_HeroTp) ) )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_HomeLeave2 takes nothing returns nothing\r\n    set gg_trg_HomeLeave2 = CreateTrigger()\r\n    call TriggerRegisterEnterRectSimple( gg_trg_HomeLeave2, gg_rct_BossSpawn )\r\n    call TriggerAddAction( gg_trg_HomeLeave2, function Trig_HomeLeave2_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}