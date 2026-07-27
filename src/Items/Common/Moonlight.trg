{
  "Id": 50332466,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Moonlight_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0CC'\r\nendfunction\r\n\r\nfunction Trig_Moonlight_Actions takes nothing returns nothing\r\n    local integer i = 1\r\n    local integer iEnd\r\n    local unit caster = null\r\n\r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0CC'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set iEnd = eyest( caster )\r\n    loop\r\n        exitwhen i > iEnd\r\n        call GroupAoE( caster, GetUnitX(caster), GetUnitY(caster), 200, 600, TARGET_ENEMY, null, \"Abilities\\\\Spells\\\\NightElf\\\\Starfall\\\\StarfallTarget.mdl\" )\r\n        set i = i + 1\r\n    endloop\r\n    \r\n    call spectime( \"Abilities\\\\Spells\\\\NightElf\\\\Starfall\\\\StarfallCaster.mdl\", GetUnitX(caster), GetUnitY(caster), 2.5 )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Moonlight takes nothing returns nothing\r\n    set gg_trg_Moonlight = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Moonlight, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Moonlight, Condition( function Trig_Moonlight_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Moonlight, function Trig_Moonlight_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}