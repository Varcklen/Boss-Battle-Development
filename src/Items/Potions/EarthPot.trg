{
  "Id": 50332817,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_EarthPot_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0IY'\r\nendfunction\r\n\r\nfunction Trig_EarthPot_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local real heal\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( \"|cf020FF20 Earth\", caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set heal = 225 * udg_SpellDamagePotion[GetPlayerId( GetOwningPlayer( caster ) ) + 1]\r\n    set IsHealFromPotion = true\r\n    call healst( caster, null, heal )\r\n    call potionst( caster )\r\n    call spectimeunit( caster, \"Abilities\\\\Spells\\\\Human\\\\Heal\\\\HealTarget.mdl\", \"origin\", 2 )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_EarthPot takes nothing returns nothing\r\n    set gg_trg_EarthPot = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_EarthPot, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_EarthPot, Condition( function Trig_EarthPot_Conditions ) )\r\n    call TriggerAddAction( gg_trg_EarthPot, function Trig_EarthPot_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}