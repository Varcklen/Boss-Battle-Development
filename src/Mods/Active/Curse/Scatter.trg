{
  "Id": 50332233,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Scatter_Conditions takes nothing returns boolean\r\n    return GetOwningPlayer(GetDyingUnit()) == Player(10) and GetUnitName(GetDyingUnit()) != \"dummy\"\r\nendfunction\r\n\r\nfunction Trig_Scatter_Actions takes nothing returns nothing\r\n    call GroupAoE( GetDyingUnit(), 0, 0, 35, 300, \"enemy\", \"war3mapImported\\\\ArcaneExplosion.mdx\", \"\" )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Scatter takes nothing returns nothing\r\n    set gg_trg_Scatter = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Scatter )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Scatter, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Scatter, Condition( function Trig_Scatter_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Scatter, function Trig_Scatter_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}