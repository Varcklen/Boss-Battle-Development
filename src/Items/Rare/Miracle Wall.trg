{
  "Id": 50332628,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Miracle_Wall_Conditions takes nothing returns boolean\r\n    return combat( udg_DamageEventTarget, false, 0 ) and luckylogic( udg_DamageEventTarget, 8, 1, 100 ) and ( inv(udg_DamageEventTarget, 'I03Z') > 0 or ( inv(udg_DamageEventTarget, 'I030') > 0 and udg_Set_Weapon_Logic[GetPlayerId(GetOwningPlayer(udg_DamageEventTarget)) + 1 + 92] ) )\r\nendfunction\r\n\r\nfunction Trig_Miracle_Wall_Actions takes nothing returns nothing\r\n    local integer rand = GetRandomInt( 1, 3 )\r\n    set udg_RandomLogic = true\r\n    set udg_Caster = udg_DamageEventTarget\r\n    set udg_Level = 1\r\n    if rand == 1 then\r\n        call TriggerExecute( udg_DB_Trigger_One[GetRandomInt( 1, udg_Database_NumberItems[14])] )\r\n    elseif rand == 2 then\r\n        call TriggerExecute( udg_DB_Trigger_Two[GetRandomInt( 1, udg_Database_NumberItems[15])] )\r\n    else\r\n        call TriggerExecute( udg_DB_Trigger_Three[GetRandomInt( 1, udg_Database_NumberItems[16])] )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Miracle_Wall takes nothing returns nothing\r\n    set gg_trg_Miracle_Wall = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Miracle_Wall, \"udg_DamageModifierEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Miracle_Wall, Condition( function Trig_Miracle_Wall_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Miracle_Wall, function Trig_Miracle_Wall_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}