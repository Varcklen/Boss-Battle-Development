{
  "Id": 50332939,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Superbots_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0RF'\r\nendfunction\r\n\r\nfunction Trig_Superbots_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local integer cyclA = 1\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0RF'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    loop\r\n        exitwhen cyclA > 3\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'n00U', GetUnitX( caster ) + GetRandomReal( -200, 200 ), GetUnitY( caster ) + GetRandomReal( -200, 200 ), GetRandomReal( 0, 360 ) )\r\n        call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\FlakCannons\\\\FlakTarget.mdl\", bj_lastCreatedUnit, \"origin\") )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Superbots takes nothing returns nothing\r\n    set gg_trg_Superbots = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Superbots, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Superbots, Condition( function Trig_Superbots_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Superbots, function Trig_Superbots_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}