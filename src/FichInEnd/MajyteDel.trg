{
  "Id": 50333713,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MajyteDel_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel(GetSpellAbilityUnit(), 'A0YC') > 0 and GetSpellAbilityId() != 'A0YA'\r\nendfunction\r\n\r\nfunction Trig_MajyteDel_Actions takes nothing returns nothing\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( GetSpellAbilityUnit() ), StringHash( \"majt\" ) ), 0, false, function MajyteCast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MajyteDel takes nothing returns nothing\r\n    set gg_trg_MajyteDel = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MajyteDel, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_MajyteDel, Condition( function Trig_MajyteDel_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MajyteDel, function Trig_MajyteDel_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}