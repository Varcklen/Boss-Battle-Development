{
  "Id": 50333479,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Illusionist6_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h020' and GetUnitLifePercent(udg_DamageEventTarget) <= 40\r\nendfunction\r\n\r\nfunction Trig_Illusionist6_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local real hp\r\n    local real mp\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    loop\r\n        exitwhen cyclA > 4\r\n\tif GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 then\r\n\t\tset hp = GetUnitState(udg_hero[cyclA], UNIT_STATE_LIFE)/GetUnitState(udg_hero[cyclA], UNIT_STATE_MAX_LIFE)\r\n\t\tset mp = GetUnitState(udg_hero[cyclA], UNIT_STATE_MANA)/GetUnitState(udg_hero[cyclA], UNIT_STATE_MAX_MANA)\r\n    \t\tcall SetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE, GetUnitState( udg_hero[cyclA], UNIT_STATE_MAX_LIFE) * mp )\r\n    \t\tcall SetUnitState( udg_hero[cyclA], UNIT_STATE_MANA, GetUnitState( udg_hero[cyclA], UNIT_STATE_MAX_MANA) * hp )\r\n                call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Undead\\\\ReplenishMana\\\\ReplenishManaCasterOverhead.mdl\", udg_hero[cyclA], \"origin\") )\r\n\tendif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Illusionist6 takes nothing returns nothing\r\n    set gg_trg_Illusionist6 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Illusionist6 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Illusionist6, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Illusionist6, Condition( function Trig_Illusionist6_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Illusionist6, function Trig_Illusionist6_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}