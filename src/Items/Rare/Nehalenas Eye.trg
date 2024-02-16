{
  "Id": 50332636,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Nehalenas_Eye_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A05E'\r\nendfunction\r\n\r\nfunction Trig_Nehalenas_Eye_Actions takes nothing returns nothing\r\n    local integer k = GetPlayerId( GetOwningPlayer( GetSpellTargetUnit() ) )*3\r\n    local item it = GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I0FD')\r\n    local integer id = GetHandleId(it) \r\n\r\n    call SaveInteger( udg_hash, id, StringHash( \"frg1\" ), 0 )\r\n    call SaveInteger( udg_hash, id, StringHash( \"frg2\" ), 0 )\r\n    call SaveInteger( udg_hash, id, StringHash( \"frg3\" ), 0 )\r\n    \r\n    call forge( GetSpellAbilityUnit(), it, udg_LastReward[k+1], udg_LastReward[k+2], udg_LastReward[k+3], true )\r\n    \r\n    set it = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Nehalenas_Eye takes nothing returns nothing\r\n    set gg_trg_Nehalenas_Eye = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Nehalenas_Eye, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Nehalenas_Eye, Condition( function Trig_Nehalenas_Eye_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Nehalenas_Eye, function Trig_Nehalenas_Eye_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}