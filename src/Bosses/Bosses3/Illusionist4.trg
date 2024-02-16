{
  "Id": 50333477,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "//TESH.scrollpos=0\r\n//TESH.alwaysfold=0\r\nfunction Trig_Illusionist4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h020' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_Illusionist4_Actions takes nothing returns nothing\r\n    local integer rand = GetRandomInt( 1, 2 )\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    if rand == 1 then\r\n    \tcall SaveBoolean( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsilb\" ), false )\r\n    endif\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\DarkRitual\\\\DarkRitualTarget.mdl\", udg_DamageEventTarget, \"origin\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Illusionist4 takes nothing returns nothing\r\n    set gg_trg_Illusionist4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Illusionist4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Illusionist4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Illusionist4, Condition( function Trig_Illusionist4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Illusionist4, function Trig_Illusionist4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}