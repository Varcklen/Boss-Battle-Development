{
  "Id": 50332825,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SwampPot_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0QT'\r\nendfunction\r\n\r\nfunction Trig_SwampPot_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local real hp\r\n    local real mp\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( \"|cf0006400 Swamp\", caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    set hp = 800 * udg_SpellDamagePotion[GetPlayerId( GetOwningPlayer( caster ) ) + 1]\r\n    set mp = 500 * udg_SpellDamagePotion[GetPlayerId( GetOwningPlayer( caster ) ) + 1]\r\n    \r\n    set IsHealFromPotion = true\r\n    call healst( caster, null, hp )\r\n    call manast( caster, null, mp )\r\n    call potionst( caster )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"war3mapImported\\\\HolyAwakening.mdx\", caster, \"origin\" ) )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SwampPot takes nothing returns nothing\r\n    set gg_trg_SwampPot = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_SwampPot, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_SwampPot, Condition( function Trig_SwampPot_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SwampPot, function Trig_SwampPot_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}