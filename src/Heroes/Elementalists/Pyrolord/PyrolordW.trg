{
  "Id": 50333253,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant real PYROLORD_W_START_DAMAGE = 75\r\n    constant real PYROLORD_W_UPGRADE_DAMAGE = 15\r\nendglobals\r\n\r\nfunction Trig_PyrolordW_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0NK'\r\nendfunction\r\n\r\nfunction PyrolordW_Damage takes unit dealer, unit target, real damage returns nothing\r\n\r\n    call DestroyEffect( AddSpecialEffect(\"Abilities\\\\Spells\\\\Other\\\\Incinerate\\\\FireLordDeathExplode.mdl\", GetUnitX(target), GetUnitY(target) ) )\r\n    call UnitDamageTarget( dealer, target, damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n    \r\n    set dealer = null\r\n    set target = null\r\nendfunction\r\n\r\nfunction Trig_PyrolordW_Actions takes nothing returns nothing\r\n    local real dmg\r\n    local unit caster\r\n    local unit target\r\n    local integer lvl\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"enemy\", \"\", \"\", \"\", \"\" )\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A0NK'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif\r\n    \r\n    set dmg = PyrolordExtraDamage + PYROLORD_W_START_DAMAGE + ( PYROLORD_W_UPGRADE_DAMAGE * lvl )\r\n\r\n    call dummyspawn( caster, 1, 0, 0, 0 )\r\n    call PyrolordW_Damage(bj_lastCreatedUnit, target, dmg)\r\n    \r\n    if GetUnitAbilityLevel( target, 'B034') > 0 then\r\n        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( target ), StringHash( \"prlq\" ) ), 0.01, false, function PyrolordQCast )\r\n        call PyrolordW_Damage(bj_lastCreatedUnit, target, dmg)\r\n    endif\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PyrolordW takes nothing returns nothing\r\n    set gg_trg_PyrolordW = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PyrolordW, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_PyrolordW, Condition( function Trig_PyrolordW_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PyrolordW, function Trig_PyrolordW_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}