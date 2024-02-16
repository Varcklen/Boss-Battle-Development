{
  "Id": 50333414,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Kobold1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventSource) == 'n00P' and GetRandomInt(1, 5) == 1\r\nendfunction\r\n\r\nfunction Trig_Kobold1_Actions takes nothing returns nothing\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    \r\n    call GroupEnumUnitsInRange( g, GetUnitX( udg_DamageEventSource ), GetUnitY( udg_DamageEventSource ), 600, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        if unitst( u, udg_DamageEventSource, \"enemy\" ) then\r\n    \t    call SetUnitState( u, UNIT_STATE_LIFE, RMaxBJ(0,GetUnitState( u, UNIT_STATE_LIFE) - 40 ))\r\n            call DestroyEffect(AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Thunderclap\\\\ThunderClapCaster.mdl\", u, \"origin\") )\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n        set u = FirstOfGroup(g)\r\n    endloop\r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Kobold1 takes nothing returns nothing\r\n    set gg_trg_Kobold1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Kobold1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Kobold1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Kobold1, Condition( function Trig_Kobold1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Kobold1, function Trig_Kobold1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}