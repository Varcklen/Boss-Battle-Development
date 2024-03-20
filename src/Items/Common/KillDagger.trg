{
  "Id": 50332461,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_KillDagger_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A020'\r\nendfunction\r\n\r\nfunction Trig_KillDagger_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A02H'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    set cyclAEnd = eyest( caster )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\RaiseSkeletonWarrior\\\\RaiseSkeleton.mdl\", caster, \"origin\" ) )\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        if GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 then\r\n            call UnitDamageTarget( caster, caster, 150, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n            call manast( caster, null, 100 )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_KillDagger takes nothing returns nothing\r\n    set gg_trg_KillDagger = CreateTrigger()\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_KillDagger, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_KillDagger, Condition( function Trig_KillDagger_Conditions ) )\r\n    call TriggerAddAction( gg_trg_KillDagger, function Trig_KillDagger_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}