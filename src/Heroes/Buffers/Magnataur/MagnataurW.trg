{
  "Id": 50332951,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MagnataurW_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0VG'\r\nendfunction\r\n\r\nfunction MagnataurWCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( \"mgtw\" ) ), 'A0L6' )\r\n    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( \"mgtw\" ) ), 'B03O' )\r\n    call FlushChildHashtable( udg_hash, id )\r\nendfunction\r\n\r\nfunction Trig_MagnataurW_Actions takes nothing returns nothing\r\n    local integer id\r\n    local unit caster\r\n    local unit target\r\n    local integer lvl\r\n    local real t\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n        set lvl = udg_Level\r\n        set t = udg_Time\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 300, \"enemy\", \"\", \"\", \"\", \"\" )\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A0VG'), caster, 64, 90, 10, 1.5 )\r\n        set t = 6 + lvl\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n        set t = 6 + lvl\r\n    endif\r\n    set t = timebonus(caster, t)\r\n\r\n    set id = GetHandleId( target )\r\n    \r\n    call UnitAddAbility( target, 'A0L6' )\r\n\r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"mgtw\" ) ) == null then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"mgtw\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"mgtw\" ) ) ) \r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"mgtw\" ), target )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( target ), StringHash( \"mgtw\" ) ), t, false, function MagnataurWCast )\r\n    \r\n    if BuffLogic() then\r\n        call debuffst( caster, target, null, lvl, t )\r\n    endif\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MagnataurW takes nothing returns nothing\r\n    set gg_trg_MagnataurW = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MagnataurW, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_MagnataurW, Condition( function Trig_MagnataurW_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MagnataurW, function Trig_MagnataurW_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}