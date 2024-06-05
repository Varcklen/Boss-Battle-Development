{
  "Id": 50332671,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sun_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A143' and not( udg_fightmod[3] ) and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )\r\nendfunction\r\n\r\nfunction Trig_Sun_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"enemy\", 0, 0, 0 )\r\n        call textst( udg_string[0] + GetObjectName('A04R'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Other\\\\Incinerate\\\\FireLordDeathExplode.mdl\", GetUnitX( target ), GetUnitY( target ) ) )\r\n    call UnitDamageTarget( caster, target, 2000, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n    \r\n    call stazisst( caster, GetItemOfTypeFromUnitBJ( caster, 'I0B1') )\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sun takes nothing returns nothing\r\n    set gg_trg_Sun = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Sun, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Sun, Condition( function Trig_Sun_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Sun, function Trig_Sun_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}