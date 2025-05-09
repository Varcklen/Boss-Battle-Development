{
  "Id": 50332710,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Blood_of_the_Ancient_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0HV'\r\nendfunction\r\n\r\nfunction Trig_Blood_of_the_Ancient_Actions takes nothing returns nothing\r\n    local integer id\r\n    local integer i\r\n    local unit caster\r\n    local integer lvl\r\n    local real t\r\n    local real heal\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        set t = udg_Time\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A0HV'), caster, 64, 90, 10, 1.5 )\r\n        set t = 25\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n        set t = 25\r\n    endif\r\n    set t = timebonus(caster, t)\r\n    \r\n    call eyest( caster )\r\n    call DestroyEffect(AddSpecialEffectTarget(\"Blood Explosion.mdx\", caster, \"origin\") )\r\n    call bufst( caster, caster, 'A0IU', 'B07T', \"bota\", t )\r\n\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Blood_of_the_Ancient takes nothing returns nothing\r\n    set gg_trg_Blood_of_the_Ancient = CreateTrigger( )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Blood_of_the_Ancient, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Blood_of_the_Ancient, Condition( function Trig_Blood_of_the_Ancient_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Blood_of_the_Ancient, function Trig_Blood_of_the_Ancient_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}