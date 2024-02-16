{
  "Id": 50332215,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Thirst_Actions takes nothing returns nothing\r\n    if IsUnitInGroup(GetSpellAbilityUnit(), udg_heroinfo) then\r\n        call healst( GetSpellAbilityUnit(), null, 20 )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Thirst takes nothing returns nothing\r\n    set gg_trg_Thirst = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Thirst )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Thirst, EVENT_PLAYER_UNIT_SPELL_FINISH )\r\n    call TriggerAddAction( gg_trg_Thirst, function Trig_Thirst_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}