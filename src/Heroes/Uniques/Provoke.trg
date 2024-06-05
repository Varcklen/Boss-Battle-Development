{
  "Id": 50332888,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Provoke_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A088' or GetSpellAbilityId() == 'A036' or GetSpellAbilityId() == 'A0RM' or GetSpellAbilityId() == 'A0RE'\r\nendfunction\r\n\r\nfunction Trig_Provoke_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    local real t\r\n    local integer x\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 600, \"enemy\", RT_ORGANIC, 0, 0 )\r\n        call textst( udg_string[0] + GetObjectName('A088'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n    set t = timebonus(caster, 4)\r\n\r\n    if not( IsUnitType( target, UNIT_TYPE_ANCIENT) ) then\r\n        set t = t * 5\r\n    endif\r\n\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\NightElf\\\\Taunt\\\\TauntCaster.mdl\" , caster, \"origin\" ) )\r\n    \r\n\tcall taunt( caster, target, t )\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Provoke takes nothing returns nothing\r\n    set gg_trg_Provoke = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Provoke, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Provoke, Condition( function Trig_Provoke_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Provoke, function Trig_Provoke_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}