{
  "Id": 50333450,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Ogre_Magi3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h00Q' and GetUnitLifePercent(udg_DamageEventTarget) <= 25.\r\nendfunction\r\n\r\nfunction Trig_Ogre_Magi3_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call SetUnitState( udg_DamageEventTarget, UNIT_STATE_LIFE, GetUnitState( udg_DamageEventTarget, UNIT_STATE_MAX_LIFE ) )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Orc\\\\WarStomp\\\\WarStompCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Ogre_Magi3 takes nothing returns nothing\r\n    set gg_trg_Ogre_Magi3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Ogre_Magi3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Ogre_Magi3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Ogre_Magi3, Condition( function Trig_Ogre_Magi3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Ogre_Magi3, function Trig_Ogre_Magi3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}