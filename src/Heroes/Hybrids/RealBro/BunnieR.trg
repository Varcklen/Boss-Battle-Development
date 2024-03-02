{
  "Id": 50333232,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_BunnieR_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A1BC'\r\nendfunction\r\n\r\nfunction Trig_BunnieR_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit owner\r\n    local real time\r\n    local integer lvl\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A1BC'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set lvl = LoadInteger( udg_hash, GetHandleId( caster ), StringHash( \"rlbar\" ) )\r\n    endif\r\n    \r\n    set owner = LoadUnitHandle( udg_hash, GetHandleId( caster ), StringHash( \"rlbqac\" ) )\r\n    if owner != null and GetUnitState( owner, UNIT_STATE_LIFE) > 0.405 then\r\n        set time = 0.25+(0.25*lvl)\r\n        call DestroyEffect( AddSpecialEffectTarget(\"war3mapImported\\\\TimeUpheaval.mdx\", owner, \"origin\" ) )\r\n        call UnitReduceCooldown( owner, time )\r\n    endif\r\n    \r\n    set caster = null\r\n    set owner = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_BunnieR takes nothing returns nothing\r\n    set gg_trg_BunnieR = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_BunnieR, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_BunnieR, Condition( function Trig_BunnieR_Conditions ) )\r\n    call TriggerAddAction( gg_trg_BunnieR, function Trig_BunnieR_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}