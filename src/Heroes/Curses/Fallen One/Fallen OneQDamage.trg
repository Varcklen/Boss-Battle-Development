{
  "Id": 50333379,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Fallen_OneQDamage_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell ) and IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) and GetUnitAbilityLevel(udg_DamageEventTarget, 'B08G') > 0\r\nendfunction\r\n\r\nfunction Fallen_OneQDamageCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local real dmg = udg_FallenOneDamage\r\n    local unit damager = LoadUnitHandle( udg_hash, id, StringHash( \"flnqdd\" ) )\r\n    local unit target = LoadUnitHandle( udg_hash, id, StringHash( \"flnqd\" ) )\r\n    \r\n    call dummyspawn( target, 1, 0, 0, 0 )\r\n    call UnitDamageTarget( bj_lastCreatedUnit, damager, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n    call FlushChildHashtable( udg_hash, id )\r\n\r\n    set damager = null\r\n    set target = null\r\nendfunction\r\n\r\nfunction Trig_Fallen_OneQDamage_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventTarget )\r\n \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"flnqd\" ) ) == null then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"flnqd\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"flnqd\" ) ) ) \r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"flnqd\" ), udg_DamageEventTarget )\r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"flnqdd\" ), udg_DamageEventSource )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"flnqd\" ) ), 0.01, false, function Fallen_OneQDamageCast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Fallen_OneQDamage takes nothing returns nothing\r\n    set gg_trg_Fallen_OneQDamage = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Fallen_OneQDamage, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Fallen_OneQDamage, Condition( function Trig_Fallen_OneQDamage_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Fallen_OneQDamage, function Trig_Fallen_OneQDamage_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}