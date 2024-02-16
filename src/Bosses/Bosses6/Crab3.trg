{
  "Id": 50333536,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Crab3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'n009' and GetUnitLifePercent(udg_DamageEventTarget) <= 65\r\nendfunction\r\n\r\nfunction Trig_Crab3_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\FrostNova\\\\FrostNovaTarget.mdl\", udg_DamageEventTarget, \"origin\" ) )\r\n    call SetUnitAbilityLevel(udg_DamageEventTarget, 'A01Y', 2 )\r\n    call SaveInteger( udg_hash, GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bscr1\" ) ) ) , StringHash( \"bscr1\" ), 2 )\r\n    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bscr1\" ) ), bosscast(9), true, function Crab1Cast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Crab3 takes nothing returns nothing\r\n    set gg_trg_Crab3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Crab3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Crab3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Crab3, Condition( function Trig_Crab3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Crab3, function Trig_Crab3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}