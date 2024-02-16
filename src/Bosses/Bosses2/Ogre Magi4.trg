{
  "Id": 50333451,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Ogre_Magi4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h00Q' and GetUnitLifePercent(udg_DamageEventTarget) <= 90.\r\nendfunction\r\n\r\nfunction Trig_Ogre_Magi4_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    if GetOwningPlayer(udg_DamageEventTarget) == Player(10) then\r\n        call dummyspawn ( udg_DamageEventTarget, 1, 'A0W3', 0, 0 )\r\n        call IssuePointOrder( bj_lastCreatedUnit, \"silence\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) )\r\n    endif\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Orc\\\\WarStomp\\\\WarStompCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Ogre_Magi4 takes nothing returns nothing\r\n    set gg_trg_Ogre_Magi4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Ogre_Magi4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Ogre_Magi4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Ogre_Magi4, Condition( function Trig_Ogre_Magi4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Ogre_Magi4, function Trig_Ogre_Magi4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}