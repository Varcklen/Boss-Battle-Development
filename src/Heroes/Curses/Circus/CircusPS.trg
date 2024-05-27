{
  "Id": 50333343,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_CircusPS_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel( GetSpellAbilityUnit(), 'A0S7') > 0 and luckylogic( GetSpellAbilityUnit(), 10 + ( 5 * GetUnitAbilityLevel(GetSpellAbilityUnit(), 'A0S7') ), 1, 100 )\r\nendfunction\r\n\r\nfunction Trig_CircusPS_Actions takes nothing returns nothing\r\n    local unit u = randomtarget( GetSpellAbilityUnit(), 900, \"enemy\", 0, 0, 0 )\r\n    \r\n    if u != null then\r\n        call DemomanCurse( GetSpellAbilityUnit(), u )\r\n    endif\r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_CircusPS takes nothing returns nothing\r\n    set gg_trg_CircusPS = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_CircusPS, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_CircusPS, Condition( function Trig_CircusPS_Conditions ) )\r\n    call TriggerAddAction( gg_trg_CircusPS, function Trig_CircusPS_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}