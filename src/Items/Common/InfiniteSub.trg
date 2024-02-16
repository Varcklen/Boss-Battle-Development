{
  "Id": 50332457,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_InfiniteSub_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A02H'\r\nendfunction\r\n\r\nfunction Trig_InfiniteSub_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A02H'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set cyclAEnd = eyest( caster )\r\n    call spectimeunit( caster, \"Abilities\\\\Spells\\\\Human\\\\Heal\\\\HealTarget.mdl\", \"origin\", 2 )\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call healst( caster, null, 250 )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_InfiniteSub takes nothing returns nothing\r\n    set gg_trg_InfiniteSub = CreateTrigger()\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_InfiniteSub, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_InfiniteSub, Condition( function Trig_InfiniteSub_Conditions ) )\r\n    call TriggerAddAction( gg_trg_InfiniteSub, function Trig_InfiniteSub_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}