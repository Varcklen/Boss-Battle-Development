{
  "Id": 50332818,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_WaterPot_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0JH'\r\nendfunction\r\n\r\nfunction Trig_WaterPot_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local real heal\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( \"|cf02020FF Water\", caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set heal = 125 * udg_SpellDamagePotion[GetPlayerId( GetOwningPlayer( caster ) ) + 1]\r\n\r\n    call manast( caster, null, heal )\r\n    call potionst( caster )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIma\\\\AImaTarget.mdl\", caster, \"origin\" ) )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_WaterPot takes nothing returns nothing\r\n    set gg_trg_WaterPot = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_WaterPot, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_WaterPot, Condition( function Trig_WaterPot_Conditions ) )\r\n    call TriggerAddAction( gg_trg_WaterPot, function Trig_WaterPot_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}