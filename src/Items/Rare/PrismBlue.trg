{
  "Id": 50332648,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "//TESH.scrollpos=0\r\n//TESH.alwaysfold=0\r\nfunction Trig_PrismBlue_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A07G'\r\nendfunction\r\n\r\nfunction Trig_PrismBlue_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd \r\n    local integer cyclB\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A07G'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set cyclAEnd  = eyest( caster )\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        set cyclB = 1\r\n        loop\r\n            exitwhen cyclB > 4\r\n            if unitst( udg_hero[cyclB], caster, \"ally\" ) then\r\n                call manast( caster, udg_hero[cyclB], 100 )\r\n                call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIma\\\\AImaTarget.mdl\", udg_hero[cyclB], \"origin\" ) )\r\n            endif\r\n            set cyclB = cyclB + 1\r\n        endloop\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PrismBlue takes nothing returns nothing\r\n    set gg_trg_PrismBlue = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PrismBlue, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_PrismBlue, Condition( function Trig_PrismBlue_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PrismBlue, function Trig_PrismBlue_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}