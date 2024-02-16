{
  "Id": 50332260,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function PvPCondition takes unit u returns boolean\r\n    local boolean l = false\r\n    if not( udg_combatlogic[GetPlayerId(GetOwningPlayer(u)) + 1] ) or (udg_fightmod[3] and udg_unit[57] != u and udg_unit[58] != u) then\r\n        set l = true\r\n    endif\r\n    set u = null\r\n    return l\r\nendfunction\r\n\r\nfunction Trig_ResTower_Conditions takes nothing returns boolean\r\n    return IsUnitInGroup(GetDyingUnit(), udg_heroinfo) and PvPCondition(GetDyingUnit()) and GetOwningPlayer(GetDyingUnit()) != Player(PLAYER_NEUTRAL_AGGRESSIVE) and GetOwningPlayer(GetDyingUnit()) != Player(10)\r\nendfunction\r\n \r\nfunction Trig_ResTower_Actions takes nothing returns nothing\r\n    call ReviveHero( GetDyingUnit(), GetRectCenterX(gg_rct_HeroTp), GetRectCenterY(gg_rct_HeroTp), true )\r\n       \r\n    call PauseUnit(GetDyingUnit(), false)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ResTower takes nothing returns nothing\r\n    set gg_trg_ResTower = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_ResTower, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_ResTower, Condition( function Trig_ResTower_Conditions ) )\r\n    call TriggerAddAction( gg_trg_ResTower, function Trig_ResTower_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}