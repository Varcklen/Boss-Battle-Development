{
  "Id": 50332868,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_AlchemyAS_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel(GetSpellAbilityUnit(), 'B08X') > 0 and luckylogic( GetSpellAbilityUnit(), 8, 1, 100 )\r\nendfunction\r\n\r\nfunction Trig_AlchemyAS_Actions takes nothing returns nothing\r\n    local integer rand = GetRandomInt(1, 10)\r\n\r\n    set udg_Caster = GetSpellAbilityUnit()\r\n    set udg_RandomLogic = true\r\n    call TriggerExecute( udg_DB_Trigger_Pot[rand] )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_AlchemyAS takes nothing returns nothing\r\n    set gg_trg_AlchemyAS = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_AlchemyAS, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_AlchemyAS, Condition( function Trig_AlchemyAS_Conditions ) )\r\n    call TriggerAddAction( gg_trg_AlchemyAS, function Trig_AlchemyAS_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}