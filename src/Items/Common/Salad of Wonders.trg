{
  "Id": 50332534,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Salad_of_Wonders_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A19X'\r\nendfunction\r\n\r\nfunction Trig_Salad_of_Wonders_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd \r\n    local integer cyclB\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A19X'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set cyclAEnd = eyest( caster )\r\n    call AddSpecialEffectTarget(\"Objects\\\\Spawnmodels\\\\NightElf\\\\EntBirthTarget\\\\EntBirthTarget.mdl\", caster, \"origin\")\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call healst( caster, null, 400 )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    if UnitInventoryCount(caster) >= 6 then\r\n        call stazisst( caster, GetItemOfTypeFromUnitBJ( caster, 'I0G6') )\r\n    endif\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Salad_of_Wonders takes nothing returns nothing\r\n    set gg_trg_Salad_of_Wonders = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Salad_of_Wonders, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Salad_of_Wonders, Condition( function Trig_Salad_of_Wonders_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Salad_of_Wonders, function Trig_Salad_of_Wonders_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}