{
  "Id": 50332848,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "//TESH.scrollpos=6\r\n//TESH.alwaysfold=0\r\nfunction Trig_DarkSmoke_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A028'\r\nendfunction\r\n\r\nfunction DarkSmokeCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( \"drks\" ) ), 'A0WV' )\r\n    call FlushChildHashtable( udg_hash, id )\r\nendfunction\r\n\r\nfunction Trig_DarkSmoke_Actions takes nothing returns nothing\r\n    local integer id \r\n    local unit caster\r\n    local real t\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set t = udg_Time\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A028'), caster, 64, 90, 10, 1.5 )\r\n        set t = 5\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set t = 5\r\n    endif\r\n    set id = GetHandleId( caster )\r\n    \r\n    call UnitAddAbility( caster, 'A0WV' )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageDeathCaster.mdl\", caster, \"origin\" ) )\r\n    \r\n    call shadowst( caster )\r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"drks\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"drks\" ), CreateTimer() )\r\n    endif\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"drks\" ) ) ) \r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"drks\" ), caster )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( \"drks\" ) ), t, false, function DarkSmokeCast )\r\n    \r\n    if BuffLogic() then\r\n        call effst( caster, caster, \"Trig_DarkSmoke_Actions\", 1, t )\r\n    endif\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DarkSmoke takes nothing returns nothing\r\n    set gg_trg_DarkSmoke = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_DarkSmoke, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_DarkSmoke, Condition( function Trig_DarkSmoke_Conditions ) )\r\n    call TriggerAddAction( gg_trg_DarkSmoke, function Trig_DarkSmoke_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}