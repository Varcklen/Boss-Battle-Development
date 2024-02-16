{
  "Id": 50333448,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Ogre_Magi1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h00Q'\r\nendfunction\r\n\r\nfunction Trig_Ogre_Magi1_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A0W2' )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Orc\\\\WarStomp\\\\WarStompCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Ogre_Magi1 takes nothing returns nothing\r\n    set gg_trg_Ogre_Magi1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Ogre_Magi1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Ogre_Magi1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Ogre_Magi1, Condition( function Trig_Ogre_Magi1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Ogre_Magi1, function Trig_Ogre_Magi1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}