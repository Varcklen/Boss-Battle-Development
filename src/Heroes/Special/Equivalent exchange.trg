{
  "Id": 50332912,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Equivalent_exchange_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A1B2'\r\nendfunction\r\n\r\nfunction Trig_Equivalent_exchange_Actions takes nothing returns nothing\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A1B2'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\RaiseSkeletonWarrior\\\\RaiseSkeleton.mdl\", caster, \"origin\" ) )\r\n    if GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 then\r\n        call UnitTakeDamage( caster, caster, 100, DAMAGE_TYPE_MAGIC)\r\n        call manast( caster, null, 60 )\r\n    endif\r\n\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Equivalent_exchange takes nothing returns nothing\r\n    set gg_trg_Equivalent_exchange = CreateTrigger()\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Equivalent_exchange, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Equivalent_exchange, Condition( function Trig_Equivalent_exchange_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Equivalent_exchange, function Trig_Equivalent_exchange_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}