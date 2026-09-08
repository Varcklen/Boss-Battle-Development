{
  "Id": 50333584,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MountGiant5_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'e000' and GetUnitLifePercent(udg_DamageEventTarget) <= 30\r\nendfunction\r\n\r\nfunction Trig_MountGiant5_Actions takes nothing returns nothing\r\n    local unit boss = udg_DamageEventTarget\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n\tcall DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\NightElf\\\\BattleRoar\\\\RoarCaster.mdl\", GetUnitX(boss), GetUnitY(boss) ) ) \r\n\tcall BlzSetUnitBaseDamage( boss, BlzGetUnitBaseDamage(boss, 0) * 2, 0 )\r\n\t\r\n\tset boss = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MountGiant5 takes nothing returns nothing\r\n    set gg_trg_MountGiant5 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_MountGiant5 )\r\n    call TriggerRegisterVariableEvent( gg_trg_MountGiant5, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_MountGiant5, Condition( function Trig_MountGiant5_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MountGiant5, function Trig_MountGiant5_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}