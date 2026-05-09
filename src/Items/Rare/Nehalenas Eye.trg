{
  "Id": 50332636,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Nehalenas_Eye_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A05E'\r\nendfunction\r\n\r\nfunction Trig_Nehalenas_Eye_Actions takes nothing returns nothing\r\n\tlocal unit target = GetSpellTargetUnit()\r\n\tlocal unit caster = GetSpellAbilityUnit()\r\n    local integer tripleIndex\r\n    local item itemUsed \r\n    local integer id\r\n\r\n\tif target == caster then\r\n\t\tcall ErrorMessage(GetOwningPlayer(caster), \"This item cannot be used on yourself.\")\r\n\t\tset caster = null\r\n\t    set itemUsed = null\r\n\t    set target = null\r\n\t\treturn\r\n\tendif\r\n\r\n\tset tripleIndex = GetPlayerId( GetOwningPlayer( target ) ) * 3\r\n\tset itemUsed = GetItemOfTypeFromUnitBJ( caster, 'I0FD')\r\n\tset id = GetHandleId(itemUsed) \r\n\r\n    call SaveInteger( udg_hash, id, StringHash( \"frg1\" ), 0 )\r\n    call SaveInteger( udg_hash, id, StringHash( \"frg2\" ), 0 )\r\n    call SaveInteger( udg_hash, id, StringHash( \"frg3\" ), 0 )\r\n    \r\n    call forge( caster, itemUsed, udg_LastReward[tripleIndex+1], udg_LastReward[tripleIndex+2], udg_LastReward[tripleIndex+3], true )\r\n    \r\n    set caster = null\r\n    set itemUsed = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Nehalenas_Eye takes nothing returns nothing\r\n    set gg_trg_Nehalenas_Eye = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Nehalenas_Eye, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Nehalenas_Eye, Condition( function Trig_Nehalenas_Eye_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Nehalenas_Eye, function Trig_Nehalenas_Eye_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}