{
  "Id": 50332373,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_RandomUse_Actions takes nothing returns nothing\r\n    set udg_RandomLogic = true\r\n    set udg_Caster = udg_hero[1]\r\n    set udg_Level = 5\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_RandomUse takes nothing returns nothing\r\n    set gg_trg_RandomUse = CreateTrigger(  )\r\n    call TriggerRegisterPlayerChatEvent( gg_trg_RandomUse, Player(0), \"1\", true )\r\n    call TriggerAddAction( gg_trg_RandomUse, function Trig_RandomUse_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}