{
  "Id": 50333035,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_InfernalSmall_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetDyingUnit()) == 'n02Y'\r\nendfunction\r\n\r\nfunction Trig_InfernalSmall_Actions takes nothing returns nothing\r\n    set bj_lastCreatedItem = CreateItem('I0G8', GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ))\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageDeathCaster.mdl\", GetItemX( bj_lastCreatedItem ), GetItemY( bj_lastCreatedItem ) ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_InfernalSmall takes nothing returns nothing\r\n    set gg_trg_InfernalSmall = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_InfernalSmall, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_InfernalSmall, Condition( function Trig_InfernalSmall_Conditions ) )\r\n    call TriggerAddAction( gg_trg_InfernalSmall, function Trig_InfernalSmall_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}