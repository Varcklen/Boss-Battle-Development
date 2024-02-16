{
  "Id": 50332218,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function HronoSpeed takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    call UnitResetCooldown( LoadUnitHandle( udg_hash, id, StringHash( \"hrspeed\" ) ) )\r\n    call FlushChildHashtable( udg_hash, id )\r\nendfunction\r\n\r\nfunction Trig_Hronospeed_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( GetSpellAbilityUnit() )\r\n\r\n    if IsUnitInGroup(GetSpellAbilityUnit(), udg_heroinfo) and 4 >= GetRandomInt( 1, 100 ) then\r\n        call DestroyEffect( AddSpecialEffect( \"war3mapImported\\\\Sci Teleport.mdx\", GetUnitX( GetSpellAbilityUnit() ), GetUnitY( GetSpellAbilityUnit() ) ) )\r\n\r\n        if LoadTimerHandle( udg_hash, id, StringHash( \"hrspeed\" ) ) == null then\r\n            call SaveTimerHandle( udg_hash, id, StringHash( \"hrspeed\" ), CreateTimer() )\r\n        endif\r\n        set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"hrspeed\" ) ) ) \r\n        call SaveUnitHandle( udg_hash, id, StringHash( \"hrspeed\" ), GetSpellAbilityUnit() )\r\n        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( GetSpellAbilityUnit() ), StringHash( \"hrspeed\" ) ), 0.1, false, function HronoSpeed ) \r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Hronospeed takes nothing returns nothing\r\n    set gg_trg_Hronospeed = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Hronospeed )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Hronospeed, EVENT_PLAYER_UNIT_SPELL_FINISH )\r\n    call TriggerAddAction( gg_trg_Hronospeed, function Trig_Hronospeed_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}