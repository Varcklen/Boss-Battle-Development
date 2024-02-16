{
  "Id": 50333524,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Manipulator3_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n02W' and GetUnitLifePercent(udg_DamageEventTarget) <= 40.\r\nendfunction\r\n\r\nfunction Trig_Manipulator3_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    loop\r\n        exitwhen cyclA > 2\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer(udg_DamageEventTarget), 'n02X', GetUnitX(udg_DamageEventTarget) + GetRandomReal( -200, 200 ), GetUnitY(udg_DamageEventTarget) + GetRandomReal( -200, 200 ), GetRandomReal( 0, 360 ) )\r\n        call DestroyEffect(AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\DarkRitual\\\\DarkRitualTarget.mdll\", bj_lastCreatedUnit, \"origin\") )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Manipulator3 takes nothing returns nothing\r\n    set gg_trg_Manipulator3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Manipulator3 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Manipulator3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Manipulator3, Condition( function Trig_Manipulator3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Manipulator3, function Trig_Manipulator3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}