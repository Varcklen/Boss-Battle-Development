{
  "Id": 50332642,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_OrbLight_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0C6'\r\nendfunction\r\n\r\nfunction Trig_OrbLight_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd \r\n    local integer cyclB\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0C6'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set cyclAEnd = eyest( caster )\r\n    call AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\HolyBolt\\\\HolyBoltSpecialArt.mdl\", caster, \"origin\")\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call healst( caster, null, 300 )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_OrbLight takes nothing returns nothing\r\n    set gg_trg_OrbLight = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_OrbLight, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_OrbLight, Condition( function Trig_OrbLight_Conditions ) )\r\n    call TriggerAddAction( gg_trg_OrbLight, function Trig_OrbLight_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}