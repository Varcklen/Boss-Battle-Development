{
  "Id": 50332952,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MagnataurP_Conditions takes nothing returns boolean\r\n     return not( udg_IsDamageSpell ) and GetUnitAbilityLevel( udg_DamageEventSource, 'A098') > 0 and luckylogic( udg_DamageEventSource, ( 3 * GetUnitAbilityLevel( udg_DamageEventSource, 'A098') ) + 1, 1, 100 )\r\nendfunction\r\n\r\nfunction Trig_MagnataurP_Actions takes nothing returns nothing\r\n    local integer rand = GetRandomInt( 1, 3 )\r\n\r\n    set udg_RandomLogic = true\r\n    set udg_Caster = udg_DamageEventSource\r\n    set udg_Level = GetUnitAbilityLevel( udg_DamageEventSource, 'A098')\r\n    if rand == 1 then\r\n        call TriggerExecute( gg_trg_MagnataurQ )\r\n    elseif rand == 2 then\r\n        call TriggerExecute( gg_trg_MagnataurW )\r\n    else\r\n        call TriggerExecute( gg_trg_MagnataurR )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MagnataurP takes nothing returns nothing\r\n    set gg_trg_MagnataurP = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_MagnataurP, \"udg_DamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_MagnataurP, Condition( function Trig_MagnataurP_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MagnataurP, function Trig_MagnataurP_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}