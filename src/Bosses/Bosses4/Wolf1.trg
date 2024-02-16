{
  "Id": 50333485,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Wolf1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'o009' and GetUnitLifePercent(udg_DamageEventTarget) <= 90\r\nendfunction\r\n\r\nfunction Trig_Wolf1_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n        loop\r\n            exitwhen cyclA > 4\r\n            set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'o00A', GetUnitX( udg_DamageEventTarget ) + GetRandomReal( -120, 120 ), GetUnitY( udg_DamageEventTarget ) + GetRandomReal( -120, 120 ), GetRandomReal(0, 360) )\r\n            call DestroyEffect(AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\", bj_lastCreatedUnit, \"origin\") )\r\n            call UnitApplyTimedLife( bj_lastCreatedUnit , 'BTLF', 15 )\r\n            set cyclA = cyclA + 1\r\n        endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Wolf1 takes nothing returns nothing\r\n    set gg_trg_Wolf1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Wolf1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Wolf1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Wolf1, Condition( function Trig_Wolf1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Wolf1, function Trig_Wolf1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}