{
  "Id": 50332436,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Goldfinch_Conditions takes nothing returns boolean\r\n    return not( udg_fightmod[3] ) and inv(GetSpellAbilityUnit(), 'I06A') > 0 and luckylogic( GetSpellAbilityUnit(), 1, 1, 100 ) and combat( GetSpellAbilityUnit(), false, 0 )\r\nendfunction\r\n\r\nfunction Trig_Goldfinch_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId( GetOwningPlayer( GetSpellAbilityUnit() ) ) + 1\r\n    \r\n    call luckyst( GetSpellAbilityUnit(), 1 )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\ResourceItems\\\\ResourceEffectTarget.mdl\", GetSpellAbilityUnit(), \"origin\") )\r\n    call textst( \"|c00FFFF00 +1 to luck\", GetSpellAbilityUnit(), 64, 90, 10, 1.5 )\r\n    set udg_Data[i + 60] = udg_Data[i + 60] + 1\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Goldfinch takes nothing returns nothing\r\n    set gg_trg_Goldfinch = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Goldfinch, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Goldfinch, Condition( function Trig_Goldfinch_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Goldfinch, function Trig_Goldfinch_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}