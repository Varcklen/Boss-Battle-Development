{
  "Id": 50333479,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Illusionist6\r\n\t\r\n\tfunction Trig_Illusionist6_Conditions takes nothing returns boolean\r\n\t    return GetUnitTypeId(udg_DamageEventTarget) == 'h020' and GetUnitLifePercent(udg_DamageEventTarget) <= 40\r\n\tendfunction\r\n\t\r\n\tfunction Trig_Illusionist6_Actions takes nothing returns nothing\r\n\t    local integer cyclA = 1\r\n\t    local real hp\r\n\t    local real mp\r\n\t    \r\n\t    call DisableTrigger( GetTriggeringTrigger() )\r\n\t    loop\r\n\t        exitwhen cyclA > 4\r\n\t\t\tif GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 then\r\n\t\t\t\tcall Illusionist5_StartHealthManaSwap(udg_hero[cyclA])\r\n\t\t\tendif\r\n\t        set cyclA = cyclA + 1\r\n\t    endloop\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tfunction InitTrig_Illusionist6 takes nothing returns nothing\r\n\t    set gg_trg_Illusionist6 = CreateTrigger(  )\r\n\t    call DisableTrigger( gg_trg_Illusionist6 )\r\n\t    call TriggerRegisterVariableEvent( gg_trg_Illusionist6, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n\t    call TriggerAddCondition( gg_trg_Illusionist6, Condition( function Trig_Illusionist6_Conditions ) )\r\n\t    call TriggerAddAction( gg_trg_Illusionist6, function Trig_Illusionist6_Actions )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}