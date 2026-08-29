{
  "Id": 50333492,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope DarkWarlock2 initializer init\r\n\t\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return GetUnitTypeId( udg_DamageEventTarget ) == 'e00D' and GetUnitLifePercent(udg_DamageEventTarget) <= 60\r\n\tendfunction\r\n\t\r\n\tprivate function DarkWar2Cast takes nothing returns nothing\r\n\t    local integer id = GetHandleId( GetExpiredTimer() )\r\n\t    local unit target\r\n\t    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( \"bsdw1\" ) )\r\n\t    \r\n\t    if GetUnitState( boss, UNIT_STATE_LIFE) <= 0.405 or not( udg_fightmod[0] ) then\r\n\t        call DestroyTimer( GetExpiredTimer() )\r\n\t        call FlushChildHashtable( udg_hash, id )\r\n\t    else\r\n\t    \tset target = DeathSystem_GetRandomAliveHero()\r\n\t    \tif target != null then\r\n\t    \t\tcall bufallst( boss, target, 'A0Y0', 0, 0, 0, 0, 'B03U', \"bsdw2\", 8 )\r\n\t    \tendif  \r\n\t    endif\r\n\t    \r\n\t    set boss = null\r\n\t    set target = null\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    call DisableTrigger( GetTriggeringTrigger() )\r\n\t    if GetOwningPlayer(udg_DamageEventTarget) == Player(10) then\r\n\t\t\tcall InvokeTimerWithUnit( udg_DamageEventTarget, \"bsdw1\", bosscast(16), true, function DarkWar2Cast )\r\n\t\tendif\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    set gg_trg_DarkWarlock2 = CreateEventTrigger( \"udg_AfterDamageEvent\", function action, function condition )\r\n\t    call DisableTrigger( gg_trg_DarkWarlock2 )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}