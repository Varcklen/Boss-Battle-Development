{
  "Id": 50332400,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Barnakle_blood_Actions takes nothing returns nothing\r\n    if inv(GetSpellAbilityUnit(), 'I0B4') > 0  then\r\n        call healst( GetSpellAbilityUnit(), null, 50 )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Barnakle_blood takes nothing returns nothing\r\n    set gg_trg_Barnakle_blood = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Barnakle_blood, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddAction( gg_trg_Barnakle_blood, function Trig_Barnakle_blood_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}