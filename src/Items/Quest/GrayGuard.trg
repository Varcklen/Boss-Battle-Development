{
  "Id": 50332770,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_GrayGuard_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A08N' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() ) and not( udg_fightmod[3] )\r\nendfunction\r\n\r\nfunction Trig_GrayGuard_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A08N'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    set bj_lastCreatedUnit = CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u000', GetUnitX( caster ), GetUnitY( caster ), 270 )\r\n    call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 3 )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Resurrect\\\\ResurrectCaster.mdl\",  bj_lastCreatedUnit, \"origin\" ) )\r\n    \r\n    set cyclAEnd = eyest( caster )\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call SetHeroLevel( caster, GetHeroLevel(caster) + 1, false )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n      \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_GrayGuard takes nothing returns nothing\r\n    set gg_trg_GrayGuard = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_GrayGuard, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_GrayGuard, Condition( function Trig_GrayGuard_Conditions ) )\r\n    call TriggerAddAction( gg_trg_GrayGuard, function Trig_GrayGuard_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}