{
  "Id": 50332372,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": true,
  "Script": "function Trig_AnyHero_Actions takes nothing returns nothing\r\n    //Если активно, можно выбрать героя даже если он  уже выбран\r\n    set udg_logic[35] = true\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_AnyHero takes nothing returns nothing\r\n    set gg_trg_AnyHero = CreateTrigger(  )\r\n    call TriggerAddAction( gg_trg_AnyHero, function Trig_AnyHero_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}