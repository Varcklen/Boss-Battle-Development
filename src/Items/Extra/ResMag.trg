{
  "Id": 50332849,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_ResMag_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0WY'\r\nendfunction\r\n\r\nfunction ResMagCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( \"rsmg\" ) ), 'A0WX' )\r\n    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( \"rsmg\" ) ), 'B05E' )\r\n    call FlushChildHashtable( udg_hash, id )\r\nendfunction\r\n\r\nfunction Trig_ResMag_Actions takes nothing returns nothing\r\n    local integer id \r\n    local unit caster\r\n    local real t\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set t = udg_Time\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0WY'), caster, 64, 90, 10, 1.5 )\r\n        set t = 10\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set t = 10\r\n    endif\r\n    set id = GetHandleId( caster )\r\n    \r\n    call UnitAddAbility( caster, 'A0WX' )\r\n    \r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"rsmg\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"rsmg\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"rsmg\" ) ) ) \r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"rsmg\" ), caster )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( \"rsmg\" ) ), t, false, function ResMagCast )\r\n    \r\n    if BuffLogic() then\r\n        call effst( caster, caster, \"Trig_ResMag_Actions\", 1, t )\r\n    endif\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ResMag takes nothing returns nothing\r\n    set gg_trg_ResMag = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_ResMag, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_ResMag, Condition( function Trig_ResMag_Conditions ) )\r\n    call TriggerAddAction( gg_trg_ResMag, function Trig_ResMag_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}