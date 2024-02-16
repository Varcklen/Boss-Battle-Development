{
  "Id": 50332517,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sapphire_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0LZ'\r\nendfunction\r\n\r\nfunction Trig_Sapphire_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd \r\n    local unit caster\r\n    local unit target\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0LZ'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif \r\n\r\n    set cyclAEnd  = eyest( caster )\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call manast( caster, null, 40 )\r\n        call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIma\\\\AImaTarget.mdl\", caster, \"origin\" ) )\r\n        if luckylogic( caster, 25, 1, 100 ) then\r\n            set target = GroupPickRandomUnit(udg_otryad)\r\n            call manast( GetSpellAbilityUnit(), target, 40 )\r\n            call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIma\\\\AImaTarget.mdl\", target, \"origin\" ) )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sapphire takes nothing returns nothing\r\n    set gg_trg_Sapphire = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Sapphire, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Sapphire, Condition( function Trig_Sapphire_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Sapphire, function Trig_Sapphire_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}