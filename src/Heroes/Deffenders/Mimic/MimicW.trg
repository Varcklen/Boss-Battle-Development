{
  "Id": 50333024,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MimicW_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A099'\r\nendfunction\r\n\r\nfunction Trig_MimicW_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    local integer lvl\r\n    local real dmg\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    local integer i\r\n    local integer rand\r\n    local unit u\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 300, \"enemy\", \"\", \"\", \"\", \"\" )\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A099'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif\r\n    set dmg = 40 + (40*lvl)\r\n    \r\n    call DestroyEffect( AddSpecialEffectTarget( \"Objects\\\\Spawnmodels\\\\NightElf\\\\NECancelDeath\\\\NECancelDeath.mdl\", target, \"origin\" ) )\r\n    call dummyspawn( caster, 1, 0, 0, 0 )\r\n    call UnitDamageTarget(bj_lastCreatedUnit, target, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n    \r\n    if not( udg_fightmod[3] ) and combat( caster, false, 0 ) and GetUnitState( target, UNIT_STATE_LIFE) <= 0.405 then\r\n        set rand = GetRandomInt(1, 3)\r\n        if rand == 1 then\r\n            call statst( caster, 1, 0, 0, 220, false )\r\n            call textst( \"|c00FF2020 +1 strength\", caster, 64, 90, 10, 1 )\r\n        elseif rand == 2 then\r\n            call statst( caster, 0, 1, 0, 224, false )\r\n            call textst( \"|c0020FF20 +1 agility\", caster, 64, 90, 10, 1 )\r\n        elseif rand == 3 then\r\n            call statst( caster, 0, 0, 1, 228, false )\r\n            call textst( \"|c002020FF +1 intelligence\", caster, 64, 90, 10, 1 )\r\n        endif\r\n    endif\r\n\r\n    set i = GetPlayerId(GetOwningPlayer( caster )) + 1\r\n    if udg_Set_Cristall_Number[i] > 0 then\r\n\tset cyclAEnd = udg_Set_Cristall_Number[i]\r\n\tloop\r\n\t\texitwhen cyclA > cyclAEnd\r\n\t\tset u = randomtarget( caster, 300, \"enemy\", \"\", \"\", \"\", \"\" )\r\n\t\tif u == null then\r\n\t\t\tset cyclA = cyclAEnd\r\n\t\telse\r\n    \t\t\tcall DestroyEffect( AddSpecialEffectTarget( \"Objects\\\\Spawnmodels\\\\NightElf\\\\NECancelDeath\\\\NECancelDeath.mdl\", target, \"origin\" ) )\r\n    \t\t\tcall UnitDamageTarget(bj_lastCreatedUnit, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n    \r\n    \t\t\tif not( udg_fightmod[3] ) and combat( caster, false, 0 ) and GetUnitState( u, UNIT_STATE_LIFE) <= 0.405 then\r\n        \t\t\tset rand = GetRandomInt(1, 3)\r\n        \t\t\tif rand == 1 then\r\n          \t\t\t\tcall statst( caster, 1, 0, 0, 220, false )\r\n            \t\t\t\tcall textst( \"|c00FF2020 +1 strength\", caster, 64, 90, 10, 1 )\r\n        \t\t\telseif rand == 2 then\r\n            \t\t\t\tcall statst( caster, 0, 1, 0, 224, false )\r\n            \t\t\t\tcall textst( \"|c0020FF20 +1 agility\", caster, 64, 90, 10, 1 )\r\n        \t\t\telseif rand == 3 then\r\n            \t\t\t\tcall statst( caster, 0, 0, 1, 228, false )\r\n            \t\t\t\tcall textst( \"|c002020FF +1 intelligence\", caster, 64, 90, 10, 1 )\r\n        \t\t\tendif\r\n    \t\t\tendif\r\n\t\tendif\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\n    endif\r\n\r\n    set target = null\r\n    set caster = null\r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MimicW takes nothing returns nothing\r\n    set gg_trg_MimicW = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MimicW, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_MimicW, Condition( function Trig_MimicW_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MimicW, function Trig_MimicW_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}