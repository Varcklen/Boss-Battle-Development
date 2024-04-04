{
  "Id": 50332862,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MoonA_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel(GetSpellAbilityUnit(), 'B08W') > 0\r\nendfunction\r\n\r\nfunction Trig_MoonA_Actions takes nothing returns nothing\r\n    call MoonTrigger(GetSpellAbilityUnit())\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MoonA takes nothing returns nothing\r\n    set gg_trg_MoonA = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MoonA, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_MoonA, Condition( function Trig_MoonA_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MoonA, function Trig_MoonA_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}