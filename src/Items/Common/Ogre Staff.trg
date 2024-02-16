{
  "Id": 50332489,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Ogre_Staff_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventSource) != 'u000' and luckylogic( udg_DamageEventSource, 5, 1, 100 ) and ( inv( udg_DamageEventSource, 'I09F') > 0 or ( inv( udg_DamageEventSource, 'I030') > 0 and udg_Set_Weapon_Logic[GetPlayerId(GetOwningPlayer(udg_DamageEventSource)) + 1 + 64] ) )\r\nendfunction\r\n\r\nfunction Trig_Ogre_Staff_Actions takes nothing returns nothing\r\n    call manast( udg_DamageEventSource, null, 20 )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIma\\\\AImaTarget.mdl\", udg_DamageEventSource, \"origin\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Ogre_Staff takes nothing returns nothing\r\n    set gg_trg_Ogre_Staff = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Ogre_Staff, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Ogre_Staff, Condition( function Trig_Ogre_Staff_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Ogre_Staff, function Trig_Ogre_Staff_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}