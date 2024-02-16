{
  "Id": 50332906,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Revitalization_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A19R'\r\nendfunction\r\n\r\nfunction Trig_Revitalization_Actions takes nothing returns nothing\r\n    local integer id\r\n    local unit caster\r\n    local real x\r\n    local real y\r\n\r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A19R'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set x = GetUnitX( caster ) + 200 * Cos( 0.017 * GetUnitFacing( caster ) )\r\n    set y = GetUnitY( caster ) + 200 * Sin( 0.017 * GetUnitFacing( caster ) )\r\n\r\n    set bj_lastCreatedUnit = resst( GetOwningPlayer( GetSpellAbilityUnit() ), x, y, GetUnitFacing( GetSpellAbilityUnit() ) )\r\n    call DestroyEffect(AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Undead\\\\AnimateDead\\\\AnimateDeadTarget.mdl\", bj_lastCreatedUnit, \"origin\"))\r\n    call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 25 )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Revitalization takes nothing returns nothing\r\n    set gg_trg_Revitalization = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Revitalization, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Revitalization, Condition( function Trig_Revitalization_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Revitalization, function Trig_Revitalization_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}