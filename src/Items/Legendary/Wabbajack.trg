{
  "Id": 50332768,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Wabbajack_Conditions takes nothing returns boolean\r\n    return /*inv( GetSpellAbilityUnit(), 'I03E' ) > 0 and*/ combat( GetSpellAbilityUnit(), false, 0 )\r\nendfunction\r\n\r\nfunction Trig_Wabbajack_Actions takes nothing returns nothing\r\n    local integer rand = GetRandomInt( 1, 3 )\r\n    \r\n    set udg_RandomLogic = true\r\n    set udg_Caster = GetSpellAbilityUnit()\r\n    set udg_Level = 3\r\n    if rand == 1 then\r\n        call TriggerExecute( udg_DB_Trigger_One[GetRandomInt( 1, udg_Database_NumberItems[14])] )\r\n    elseif rand == 2 then\r\n        call TriggerExecute( udg_DB_Trigger_Two[GetRandomInt( 1, udg_Database_NumberItems[15])] )\r\n    else\r\n        call TriggerExecute( udg_DB_Trigger_Three[GetRandomInt( 1, udg_Database_NumberItems[16])] )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Wabbajack takes nothing returns nothing\r\n    /*set gg_trg_Wabbajack = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Wabbajack, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Wabbajack, Condition( function Trig_Wabbajack_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Wabbajack, function Trig_Wabbajack_Actions )*/\r\n    \r\n    call RegisterDuplicatableItemType('I03E', EVENT_PLAYER_UNIT_SPELL_EFFECT, function Trig_Wabbajack_Actions, function Trig_Wabbajack_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}