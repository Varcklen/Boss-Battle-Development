{
  "Id": 50332711,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Blood_of_the_AncientCast_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel(GetSpellAbilityUnit(), 'B07T') > 0 and GetSpellAbilityId() != 'A0HV'\r\nendfunction\r\n\r\nfunction SpellBloodEnd takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( \"bldcst\" ) )\r\n\tlocal integer i = LoadInteger( udg_hash, id, StringHash( \"bldcst\" ) )\r\n\tlocal integer sp = LoadInteger( udg_hash, id, StringHash( \"bldcstsp\" ) )\r\n\tlocal integer lvl = LoadInteger( udg_hash, id, StringHash( \"bldcstlvl\" ) )\r\n    \r\n    if sp != 0 and GetUnitAbilityLevel(caster, sp) > 0 then\r\n        call BlzSetUnitAbilityManaCost( caster, sp, lvl, i )\r\n    endif\r\n\r\n    call FlushChildHashtable( udg_hash, id )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\nfunction Trig_Blood_of_the_AncientCast_Actions takes nothing returns nothing\r\n\tlocal integer id = GetHandleId( GetSpellAbilityUnit() )\r\n\tlocal integer sp = GetSpellAbilityId()\r\n\tlocal integer lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId() )-1\r\n    local integer i = BlzGetAbilityManaCost( GetSpellAbilityId(), lvl )\r\n\r\n\tcall BlzSetUnitAbilityManaCost( GetSpellAbilityUnit(), sp, lvl, 0 )\r\n\r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"bldcst\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"bldcst\" ), CreateTimer() )\r\n    endif\r\n    set id = GetHandleId( LoadTimerHandle(udg_hash, id, StringHash( \"bldcst\" ) ) )\r\n    call SaveUnitHandle( udg_hash, id, StringHash( \"bldcst\" ), GetSpellAbilityUnit() )\r\n    call SaveInteger( udg_hash, id, StringHash( \"bldcst\" ), i )\r\n    call SaveInteger( udg_hash, id, StringHash( \"bldcstlvl\" ), lvl )\r\n    call SaveInteger( udg_hash, id, StringHash( \"bldcstsp\" ), sp )\r\n    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( GetSpellAbilityUnit() ), StringHash( \"bldcst\" ) ), 0.01, false, function SpellBloodEnd )\r\n\r\n    call SetUnitState( GetSpellAbilityUnit(), UNIT_STATE_LIFE, RMaxBJ(0,GetUnitState( GetSpellAbilityUnit(), UNIT_STATE_LIFE) - i ))\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Blood_of_the_AncientCast takes nothing returns nothing\r\n    set gg_trg_Blood_of_the_AncientCast = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Blood_of_the_AncientCast, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Blood_of_the_AncientCast, Condition( function Trig_Blood_of_the_AncientCast_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Blood_of_the_AncientCast, function Trig_Blood_of_the_AncientCast_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}