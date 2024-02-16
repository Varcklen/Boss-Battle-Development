{
  "Id": 50332600,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Fire_in_Bottle_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A126'\r\nendfunction\r\n\r\nfunction Trig_Fire_in_Bottle_Actions takes nothing returns nothing\r\n    local integer x\r\n    local unit caster\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A126'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set x = eyest( caster ) \r\n    call UnitAddAbility( caster, 'A128' )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Fire_in_Bottle takes nothing returns nothing\r\n    set gg_trg_Fire_in_Bottle = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Fire_in_Bottle, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Fire_in_Bottle, Condition( function Trig_Fire_in_Bottle_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Fire_in_Bottle, function Trig_Fire_in_Bottle_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}