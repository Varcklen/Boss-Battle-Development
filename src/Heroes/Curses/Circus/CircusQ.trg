{
  "Id": 50333340,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_CircusQ_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0SH'\r\nendfunction\r\n\r\nfunction Trig_CircusQ_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    local integer lvl\r\n    local integer i = 1\r\n    local integer cyclA = 1\r\n    local real dmg\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"enemy\", \"\", \"\", \"\", \"\" )\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A0SH'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif\r\n\r\n    call dummyspawn( caster, 1, 0, 0, 0 )\r\n    set dmg = 60 + ( 40 * lvl )\r\n    loop\r\n        exitwhen cyclA > 1\r\n        call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\Thunderclap\\\\ThunderClapCaster.mdl\", target, \"origin\" ) )\r\n        call UnitDamageTarget( bj_lastCreatedUnit, target, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n        call DemomanCurse( caster, target )\r\n        if luckylogic( caster, 25 + ( 5 * lvl ), 1, 100 ) and GetUnitState( target, UNIT_STATE_LIFE) > 0.405 and i <= 10 then\r\n            set cyclA = cyclA - 1\r\n            set i = i + 1\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_CircusQ takes nothing returns nothing\r\n    set gg_trg_CircusQ = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_CircusQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_CircusQ, Condition( function Trig_CircusQ_Conditions ) )\r\n    call TriggerAddAction( gg_trg_CircusQ, function Trig_CircusQ_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}