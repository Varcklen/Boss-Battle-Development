{
  "Id": 50333259,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_EnergyballW_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0V1'\r\nendfunction\r\n\r\nfunction EnergyballWCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( \"enbw\" ) ), 'A0V3' )\r\n    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( \"enbw\" ) ), 'B057' )\r\n    call FlushChildHashtable( udg_hash, id )\r\nendfunction\r\n\r\nfunction Trig_EnergyballW_Actions takes nothing returns nothing\r\n    local integer id \r\n    local real dmg \r\n    local unit caster\r\n    local unit target\r\n    local integer lvl \r\n    local real t\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n        set lvl = udg_Level\r\n        set t = udg_Time\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"ally\", \"\", \"\", \"\", \"\" )\r\n        set lvl = udg_Level\r\n        set t = 30\r\n        call textst( udg_string[0] + GetObjectName('A0V1'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n        set t = 30\r\n    endif\r\n    set t = timebonus(caster, t)\r\n    \r\n    set id = GetHandleId( target )\r\n    set dmg = 10 * lvl\r\n    \r\n    call UnitAddAbility( target, 'A0V3' )\r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"enbw\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"enbw\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"enbw\" ) ) ) \r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"enbw\" ), target )\r\n    call SaveReal( udg_hash, id, StringHash( \"enbw\" ), dmg )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( target ), StringHash( \"enbw\" ) ), t, false, function EnergyballWCast )\r\n    \r\n    if BuffLogic() then\r\n        call effst( caster, target, \"Trig_EnergyballW_Actions\", lvl, t )\r\n    endif\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_EnergyballW takes nothing returns nothing\r\n    set gg_trg_EnergyballW = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_EnergyballW, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_EnergyballW, Condition( function Trig_EnergyballW_Conditions ) )\r\n    call TriggerAddAction( gg_trg_EnergyballW, function Trig_EnergyballW_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}