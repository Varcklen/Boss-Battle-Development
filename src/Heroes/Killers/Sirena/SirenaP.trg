{
  "Id": 50333095,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SirenaP_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A022'\r\nendfunction\r\n\r\nfunction SirenaPCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n\tlocal unit u = LoadUnitHandle( udg_hash, id, StringHash( \"sirp\" ) )\r\n\tlocal real heal = LoadReal( udg_hash, id, StringHash( \"sirp\" ) )\r\n\r\n    call healst( u, null, heal )\r\n    if GetUnitAbilityLevel( u, 'B006' ) == 0 then\r\n        call DestroyTimer( GetExpiredTimer( ) )\r\n        call FlushChildHashtable( udg_hash, id ) \r\n    endif\r\n\r\n\tset u = null\r\nendfunction\r\n\r\nfunction Trig_SirenaP_Actions takes nothing returns nothing\r\n    local integer id\r\n    local unit caster\r\n    local integer lvl\r\n    local real t\r\n    local real hp\r\n\r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n\tset lvl = udg_Level\r\n\tset t = udg_Time\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A022'), caster, 64, 90, 10, 1.5 )\r\n\tset lvl = udg_Level\r\n\tset t = 6\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n\tset lvl = GetUnitAbilityLevel( caster, 'A022' )\r\n        set t = 6\r\n    endif\r\n    set t = timebonus(caster, t)\r\n    \r\n    set hp = (0.005 + ( 0.015 * lvl )) * GetUnitState(caster, UNIT_STATE_MAX_LIFE)\r\n\r\n    set id = GetHandleId( caster )\r\n    \r\n    call dummyspawn( caster, 1, 'A00I', 0, 0 )\r\n    call shadowst( caster )\r\n    call IssueTargetOrder( bj_lastCreatedUnit, \"invisibility\", caster )\r\n    \r\n    call SaveTimerHandle( udg_hash, id, StringHash( \"sirp\" ), CreateTimer( ) ) \r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"sirp\" ) ) ) \r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"sirp\" ), caster )\r\n    call SaveReal( udg_hash, id, StringHash( \"sirp\" ), hp )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( \"sirp\" ) ), 1, true, function SirenaPCast ) \r\n    \r\n    if BuffLogic() then\r\n        call effst( caster, caster, \"Trig_SirenaP_Actions\", lvl, t )\r\n    endif\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SirenaP takes nothing returns nothing\r\n    set gg_trg_SirenaP = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_SirenaP, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_SirenaP, Condition( function Trig_SirenaP_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SirenaP, function Trig_SirenaP_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}