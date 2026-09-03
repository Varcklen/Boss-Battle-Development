{
  "Id": 50333519,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_GhostKnight3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'n008' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_GhostKnight3_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\DarkRitual\\\\DarkRitualTarget.mdl\", udg_DamageEventTarget, \"origin\") )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A0M6' )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A01T' )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_GhostKnight3 takes nothing returns nothing\r\n    set gg_trg_GhostKnight3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_GhostKnight3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_GhostKnight3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_GhostKnight3, Condition( function Trig_GhostKnight3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_GhostKnight3, function Trig_GhostKnight3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}