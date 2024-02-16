{
  "Id": 50333210,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_DryadEA_Conditions takes nothing returns boolean\r\n    return IsUnitEnemy( udg_DamageEventSource, GetOwningPlayer( udg_DamageEventTarget ) ) and not( udg_fightmod[3] ) and GetUnitTypeId(udg_DamageEventSource) != 'u000' and luckylogic( udg_DamageEventSource, 1+GetUnitAbilityLevel( udg_DamageEventSource, 'A0I9'), 1, 100 ) and GetUnitAbilityLevel( udg_DamageEventSource, 'A0I9') > 0 and combat( udg_DamageEventSource, false, 0 )\r\nendfunction\r\n\r\nfunction Trig_DryadEA_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIem\\\\AIemTarget.mdl\", udg_DamageEventSource, \"origin\") )\r\n    call statst( udg_DamageEventSource, 0, 1, 0, 204, true )\r\n    call textst( \"|c0020FF20 +1 agility\", udg_DamageEventSource, 64, 90, 10, 1 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DryadEA takes nothing returns nothing\r\n    set gg_trg_DryadEA = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_DryadEA, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_DryadEA, Condition( function Trig_DryadEA_Conditions ) )\r\n    call TriggerAddAction( gg_trg_DryadEA, function Trig_DryadEA_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}