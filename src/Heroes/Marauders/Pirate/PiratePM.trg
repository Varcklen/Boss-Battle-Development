{
  "Id": 50333143,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PiratePM_Conditions takes nothing returns boolean\r\n    return IsUnitInGroup(GetSpellTargetUnit(), udg_BlackMark) and GetSpellAbilityId() != 'A01F' and GetUnitName(GetSpellAbilityUnit()) != \"dummy\" and combat( GetSpellAbilityUnit(), false, 0 ) and not( udg_fightmod[3] )\r\nendfunction\r\n\r\nfunction Trig_PiratePM_Actions takes nothing returns nothing\r\n    local integer k = GetPlayerId(GetOwningPlayer(GetSpellAbilityUnit())) + 1\r\n    local integer i = GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( GetSpellTargetUnit() ), StringHash( \"pmt\" ) ) )\r\n    local integer g = LoadInteger( udg_hash, i, StringHash( \"pmt\" ) )\r\n    \r\n    call moneyst( GetSpellAbilityUnit(), g )\r\n    set udg_Data[k + 136] = udg_Data[k + 136] + g\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PiratePM takes nothing returns nothing\r\n    set gg_trg_PiratePM = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PiratePM, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_PiratePM, Condition( function Trig_PiratePM_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PiratePM, function Trig_PiratePM_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}