{
  "Id": 50333200,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MonkRA_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel( udg_DamageEventSource, 'B01O') > 0 and udg_IsDamageSpell == false\r\nendfunction\r\n\r\nfunction Trig_MonkRA_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventSource ), StringHash( \"mnkr\" ) ) ) \r\n    local integer i = LoadInteger( udg_hash, id, StringHash( \"mnkr\" ) ) - 1\r\n    \r\n    call SaveInteger( udg_hash, id, StringHash( \"mnkr\" ), i )\r\n\r\n    if i <= 0 then\r\n        call UnitRemoveAbility( udg_DamageEventSource, 'A0KE' )\r\n        call UnitRemoveAbility( udg_DamageEventSource, 'B01O' )\r\n        call DestroyTimer( LoadTimerHandle( udg_hash, id, StringHash( \"mnkr\" ) ) )\r\n        call FlushChildHashtable( udg_hash, id )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MonkRA takes nothing returns nothing\r\n    call CreateEventTrigger( \"udg_AfterDamageEvent\", function Trig_MonkRA_Actions, function Trig_MonkRA_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}