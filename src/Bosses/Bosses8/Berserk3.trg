{
  "Id": 50333588,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Berserk3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'e00F' and GetUnitLifePercent(udg_DamageEventTarget) <= 30\r\nendfunction\r\n\r\nfunction Trig_Berserk3_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'S009' )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\NightElf\\\\BattleRoar\\\\RoarCaster.mdl\", GetUnitX( udg_DamageEventTarget ), GetUnitY( udg_DamageEventTarget ) ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Berserk3 takes nothing returns nothing\r\n    set gg_trg_Berserk3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Berserk3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Berserk3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Berserk3, Condition( function Trig_Berserk3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Berserk3, function Trig_Berserk3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}