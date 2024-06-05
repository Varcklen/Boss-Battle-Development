{
  "Id": 50333204,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_ChaosLordP_Conditions takes nothing returns boolean\r\n    return udg_logic[34] and IsUnitInGroup( GetSpellAbilityUnit(), udg_heroinfo ) and udg_combatlogic[GetPlayerId( GetOwningPlayer( GetSpellAbilityUnit() ) ) + 1]\r\nendfunction\r\n\r\nfunction Trig_ChaosLordP_Actions takes nothing returns nothing\r\n\tlocal integer level = GetRandomInt( 1, 5 )\r\n\tlocal integer rand = GetRandomInt( 1, 3 )\r\n\tlocal trigger triggerUsed = null\r\n\t\r\n\tif rand == 1 then\r\n\t\tset triggerUsed = udg_DB_Trigger_One[GetRandomInt( 1, udg_Database_NumberItems[14])]\r\n\telseif rand == 2 then\r\n\t\tset triggerUsed = udg_DB_Trigger_Two[GetRandomInt( 1, udg_Database_NumberItems[15])]\r\n\telseif rand == 3 then\r\n\t\tset triggerUsed = udg_DB_Trigger_Three[GetRandomInt( 1, udg_Database_NumberItems[16])]\r\n\tendif\r\n\tcall CastRandomAbility(GetSpellAbilityUnit(), level, triggerUsed )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ChaosLordP takes nothing returns nothing\r\n    set gg_trg_ChaosLordP = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_ChaosLordP, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_ChaosLordP, Condition( function Trig_ChaosLordP_Conditions ) )\r\n    call TriggerAddAction( gg_trg_ChaosLordP, function Trig_ChaosLordP_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}