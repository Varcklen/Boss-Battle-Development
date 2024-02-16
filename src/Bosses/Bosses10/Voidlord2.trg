{
  "Id": 50333669,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Voidlord2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetDyingUnit()) == 'h008'\r\nendfunction\r\n\r\nfunction Trig_Voidlord2_Actions takes nothing returns nothing\r\n\tlocal unit u = LoadUnitHandle( udg_hash, GetHandleId( GetDyingUnit() ), StringHash( \"egg\" ) )\r\n\r\n\tcall SetUnitPosition( u, GetUnitX(GetDyingUnit()), GetUnitY(GetDyingUnit()) )\r\n    call PauseUnit( u, false )\r\n\tcall ShowUnitShow( u )\r\n\tcall DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\NightElf\\\\BattleRoar\\\\RoarCaster.mdl\", u, \"origin\" ) )\r\n\r\n\tset u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Voidlord2 takes nothing returns nothing\r\n    set gg_trg_Voidlord2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Voidlord2 )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Voidlord2, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Voidlord2, Condition( function Trig_Voidlord2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Voidlord2, function Trig_Voidlord2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}