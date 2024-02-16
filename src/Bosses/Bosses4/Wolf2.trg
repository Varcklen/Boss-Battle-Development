{
  "Id": 50333486,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Wolf2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'o009' and GetUnitLifePercent(udg_DamageEventTarget) <= 75\r\nendfunction\r\n\r\nfunction Trig_Wolf2_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    loop\r\n        exitwhen cyclA > 2\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'o00A', GetUnitX( udg_DamageEventTarget ) + GetRandomReal( -120, 120 ), GetUnitY( udg_DamageEventTarget ) + GetRandomReal( -120, 120 ), GetRandomReal(0, 360) )\r\n        call DestroyEffect(AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\", bj_lastCreatedUnit, \"origin\") )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Wolf2 takes nothing returns nothing\r\n    set gg_trg_Wolf2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Wolf2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Wolf2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Wolf2, Condition( function Trig_Wolf2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Wolf2, function Trig_Wolf2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}