{
  "Id": 50332731,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Selia_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A174'\r\nendfunction\r\n\r\nfunction SeliaCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    \r\n    call DestroyEffect( LoadEffectHandle( udg_hash, id, StringHash( \"selia\" ) ) )\r\n    call FlushChildHashtable( udg_hash, id )\r\nendfunction\r\n\r\nfunction Trig_Selia_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer x\r\n    local unit caster\r\n    local real hp\r\n    local integer id\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A174'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    set x = eyest( caster )\r\n    set hp = GetUnitState(caster, UNIT_STATE_MANA )\r\n    set bj_lastCreatedUnit = CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u000', GetUnitX( caster ), GetUnitY( caster ), 270 )\r\n    call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 3 )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Resurrect\\\\ResurrectCaster.mdl\",  bj_lastCreatedUnit, \"origin\" ) )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 and unitst( caster, udg_hero[cyclA], \"ally\" ) then\r\n            call healst( caster, udg_hero[cyclA], hp )\r\n            call DestroyEffect( AddSpecialEffect(\"Abilities\\\\Spells\\\\Human\\\\Resurrect\\\\ResurrectTarget.mdl\", GetUnitX( udg_hero[cyclA] ), GetUnitY( udg_hero[cyclA] ) ) )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set bj_lastCreatedEffect = AddSpecialEffect( \"Abilities\\\\Spells\\\\NightElf\\\\Tranquility\\\\Tranquility.mdl\", GetUnitX(caster), GetUnitY(caster) )\r\n    \r\n    set id = GetHandleId( bj_lastCreatedEffect )\r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"selia\" ) ) == null then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"selia\" ), CreateTimer() )\r\n    endif\r\n    set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"selia\" ) ) )\r\n    call SaveEffectHandle( udg_hash, id, StringHash( \"selia\" ), bj_lastCreatedEffect )\r\n    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedEffect ), StringHash( \"selia\" ) ), 2.5, false, function SeliaCast )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Selia takes nothing returns nothing\r\n    set gg_trg_Selia = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Selia, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Selia, Condition( function Trig_Selia_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Selia, function Trig_Selia_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}