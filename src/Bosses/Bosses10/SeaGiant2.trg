{
  "Id": 50333676,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SeaGiant2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'n00W' and GetUnitLifePercent(udg_DamageEventTarget) <= 80\r\nendfunction\r\n\r\nfunction Trig_SeaGiant2_Actions takes nothing returns nothing\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A0DG')\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\ControlMagic\\\\ControlMagicTarget.mdl\", udg_DamageEventTarget, \"overhead\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SeaGiant2 takes nothing returns nothing\r\n    set gg_trg_SeaGiant2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_SeaGiant2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_SeaGiant2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_SeaGiant2, Condition( function Trig_SeaGiant2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SeaGiant2, function Trig_SeaGiant2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}