{
  "Id": 50333089,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SniperPD_Conditions takes nothing returns boolean\r\n    return IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) and GetUnitAbilityLevel( udg_DamageEventTarget, 'A0LA') > 0 and udg_DamageEventAmount > 0\r\nendfunction\r\n\r\nfunction Trig_SniperPD_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n    \r\n    call UnitRemoveAbility( udg_DamageEventTarget, 'A18P' )\r\n    call UnitRemoveAbility( udg_DamageEventTarget, 'A18Q' ) \r\n    call UnitRemoveAbility( udg_DamageEventTarget, 'A18R' ) \r\n    call UnitRemoveAbility( udg_DamageEventTarget, 'B031' ) \r\n    \r\n    //if LoadTimerHandle( udg_hash, id, StringHash( \"snp\" ) ) == null then\r\n        //call SaveTimerHandle( udg_hash, id, StringHash( \"snp\" ), CreateTimer() )\r\n    //endif\r\n\t//call SaveTimerHandle( udg_hash, id, StringHash( \"snp\" ), CreateTimer( ) ) \r\n\t//set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"snp\" ) ) ) \r\n\t//call SaveUnitHandle( udg_hash, id, StringHash( \"snp\" ), udg_DamageEventTarget ) \r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"snp\" ) ), 4, false, function SniperPCast ) \r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SniperPD takes nothing returns nothing\r\n    set gg_trg_SniperPD = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_SniperPD, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_SniperPD, Condition( function Trig_SniperPD_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SniperPD, function Trig_SniperPD_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}