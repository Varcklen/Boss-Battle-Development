{
  "Id": 50333695,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_IA_TPBattle_Conditions takes nothing returns boolean\r\n    return udg_fightmod[2] and not( RectContainsUnit(gg_rct_RandomItem, GetEnteringUnit()) ) and not ( IsUnitType(GetEnteringUnit(), UNIT_TYPE_HERO) ) and ( IsUnitInGroup(udg_hero[GetPlayerId(GetOwningPlayer(GetEnteringUnit())) + 1], udg_heroinfo) or GetOwningPlayer(GetEnteringUnit()) == Player(4) )\r\nendfunction\r\n\r\nfunction Trig_IA_TPBattle_Actions takes nothing returns nothing\r\n    call SetUnitPositionLoc( GetEnteringUnit(), GetUnitLoc(GroupPickRandomUnit(udg_otryad)) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_IA_TPBattle takes nothing returns nothing\r\n    set gg_trg_IA_TPBattle = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_IA_TPBattle )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_IA_TPBattle, GetEntireMapRect() )\r\n    call TriggerAddCondition( gg_trg_IA_TPBattle, Condition( function Trig_IA_TPBattle_Conditions ) )\r\n    call TriggerAddAction( gg_trg_IA_TPBattle, function Trig_IA_TPBattle_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}