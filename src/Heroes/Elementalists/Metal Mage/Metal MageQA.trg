{
  "Id": 50333264,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Metal_MageQA_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel( udg_DamageEventSource, 'B06H') > 0 and not( udg_IsDamageSpell )\r\nendfunction\r\n\r\nfunction Trig_Metal_MageQA_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventSource ), StringHash( \"mtmq\" ) ) ) \r\n    local integer i = LoadInteger( udg_hash, id, StringHash( \"mtmq\" ) ) - 1\r\n    \r\n    call SaveInteger( udg_hash, id, StringHash( \"mtmq\" ), i )\r\n\r\n    if i <= 0 then\r\n        call UnitRemoveAbility( udg_DamageEventSource, 'A0KP' )\r\n        call UnitRemoveAbility( udg_DamageEventSource, 'B06H' )\r\n        call DestroyTimer( LoadTimerHandle( udg_hash, id, StringHash( \"mtmq\" ) ) )\r\n        call FlushChildHashtable( udg_hash, id )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Metal_MageQA takes nothing returns nothing\r\n    set gg_trg_Metal_MageQA = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Metal_MageQA, \"udg_DamageModifierEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Metal_MageQA, Condition( function Trig_Metal_MageQA_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Metal_MageQA, function Trig_Metal_MageQA_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}