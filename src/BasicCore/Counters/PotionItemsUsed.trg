{
  "Id": 50332184,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PotionItemsUsed_Conditions takes nothing returns boolean\r\n    return IsPotionItemIsUsed() and combat(GetSpellAbilityUnit(), false, 0) and not(udg_fightmod[3])\r\nendfunction\r\n\r\nfunction Trig_PotionItemsUsed_Actions takes nothing returns nothing\r\n    local integer i = GetUnitUserData(GetSpellAbilityUnit())\r\n    \r\n    set udg_PotionItemsUsed[i] = udg_PotionItemsUsed[i] + 1\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PotionItemsUsed takes nothing returns nothing\r\n    set gg_trg_PotionItemsUsed = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PotionItemsUsed, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_PotionItemsUsed, Condition( function Trig_PotionItemsUsed_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PotionItemsUsed, function Trig_PotionItemsUsed_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}