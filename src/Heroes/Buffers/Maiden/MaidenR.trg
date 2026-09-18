{
  "Id": 50332972,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MaidenR_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A16Q' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() ) and not(udg_fightmod[3])\r\nendfunction\r\n\r\nfunction Trig_MaidenR_Actions takes nothing returns nothing\r\n    local integer id \r\n    local unit caster\r\n    local unit u\r\n    local integer lvl\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A16Q'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif\r\n    \r\n    set u = DeathSystem_GetRandomDeadHero()\r\n\r\n    if u != null then\r\n         call ResInBattle( caster, u, 25+(15 * lvl) )\r\n    else\r\n    \tcall LaunchShortCooldown(caster, GetSpellAbilityId(), lvl)\r\n    endif\r\n    \r\n    set caster = null\r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MaidenR takes nothing returns nothing\r\n    set gg_trg_MaidenR = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MaidenR, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_MaidenR, Condition( function Trig_MaidenR_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MaidenR, function Trig_MaidenR_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}