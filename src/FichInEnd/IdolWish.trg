{
  "Id": 50333712,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_IdolWish_Conditions takes nothing returns boolean\r\n    return inv( GetSpellAbilityUnit(), 'I09O') > 0\r\nendfunction\r\n\r\nfunction Trig_IdolWish_Actions takes nothing returns nothing\r\n    call SetUnitState( GetSpellAbilityUnit(), UNIT_STATE_MANA, 0 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_IdolWish takes nothing returns nothing\r\n    set gg_trg_IdolWish = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_IdolWish, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_IdolWish, Condition( function Trig_IdolWish_Conditions ) )\r\n    call TriggerAddAction( gg_trg_IdolWish, function Trig_IdolWish_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}