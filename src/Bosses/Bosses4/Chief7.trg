{
  "Id": 50333508,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Chief7_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'h01X' and GetUnitLifePercent(udg_DamageEventTarget) <= 30\r\nendfunction\r\n\r\nfunction Trig_Chief7_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\DispelMagic\\\\DispelMagicTarget.mdl\", GetUnitX(udg_DamageEventTarget), GetUnitY(udg_DamageEventTarget) ) ) \r\n\tcall DelBuff( udg_DamageEventTarget, false ) \r\n\tloop\r\n\t\texitwhen cyclA > 4\r\n\t\tif GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 then\r\n        \t\tcall DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\DispelMagic\\\\DispelMagicTarget.mdl\", GetUnitX(udg_hero[cyclA]), GetUnitY(udg_hero[cyclA]) ) ) \r\n\t\t\tcall DelBuff( udg_hero[cyclA], false )\r\n\t\tendif\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Chief7 takes nothing returns nothing\r\n    set gg_trg_Chief7 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Chief7 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Chief7, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Chief7, Condition( function Trig_Chief7_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Chief7, function Trig_Chief7_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}