{
  "Id": 50333584,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MountGiant5_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'e000' and GetUnitLifePercent(udg_DamageEventTarget) <= 30\r\nendfunction\r\n\r\nfunction Trig_MountGiant5_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    \r\n\tloop\r\n\t\texitwhen cyclA > 4\r\n\t\tif GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 then\r\n        \t\tcall DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\ThunderClap\\\\ThunderClapCaster.mdl\", GetUnitX(udg_hero[cyclA]), GetUnitY(udg_hero[cyclA]) ) ) \r\n    \t\t\tcall SetUnitState( udg_hero[cyclA], UNIT_STATE_MANA, RMaxBJ(0,GetUnitState( udg_hero[cyclA], UNIT_STATE_MANA) - (0.2*GetUnitState( udg_hero[cyclA], UNIT_STATE_MAX_MANA)) ))\r\n    \t\t\tcall SetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE, RMaxBJ(0,GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) - (0.2*GetUnitState( udg_hero[cyclA], UNIT_STATE_MAX_LIFE)) ))\r\n\t\tendif\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MountGiant5 takes nothing returns nothing\r\n    set gg_trg_MountGiant5 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_MountGiant5 )\r\n    call TriggerRegisterVariableEvent( gg_trg_MountGiant5, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_MountGiant5, Condition( function Trig_MountGiant5_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MountGiant5, function Trig_MountGiant5_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}