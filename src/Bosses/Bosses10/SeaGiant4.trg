{
  "Id": 50333678,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SeaGiant4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'n00W' and GetUnitLifePercent(udg_DamageEventTarget) <= 30\r\nendfunction\r\n\r\nfunction Trig_SeaGiant4_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A0DH')\r\n    call TransmissionFromUnitWithNameBJ( bj_FORCE_ALL_PLAYERS, udg_DamageEventTarget, GetUnitName(udg_DamageEventTarget), null, \"I won’t give up so easily!\", bj_TIMETYPE_SET, 3, false )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\NightElf\\\\BattleRoar\\\\RoarCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SeaGiant4 takes nothing returns nothing\r\n    set gg_trg_SeaGiant4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_SeaGiant4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_SeaGiant4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_SeaGiant4, Condition( function Trig_SeaGiant4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SeaGiant4, function Trig_SeaGiant4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}