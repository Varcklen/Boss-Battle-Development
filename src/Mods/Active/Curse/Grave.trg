{
  "Id": 50332230,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Grave_Conditions takes nothing returns boolean\r\n    return IsUnitInGroup(GetDyingUnit(), udg_heroinfo) and not( udg_fightmod[3] ) and combat( GetDyingUnit(), false, 0 )\r\nendfunction\r\n\r\nfunction Trig_Grave_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Items\\\\AIso\\\\AIsoTarget.mdl\", GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ) ) )\r\n    call SetPlayerState( GetOwningPlayer( GetDyingUnit() ), PLAYER_STATE_RESOURCE_GOLD, IMaxBJ( 0, GetPlayerState( GetOwningPlayer( GetDyingUnit() ), PLAYER_STATE_RESOURCE_GOLD) - 50 ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Grave takes nothing returns nothing\r\n    set gg_trg_Grave = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Grave )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Grave, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Grave, Condition( function Trig_Grave_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Grave, function Trig_Grave_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}