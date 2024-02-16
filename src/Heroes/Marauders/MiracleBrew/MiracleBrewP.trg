{
  "Id": 50333136,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MiracleBrewP_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A0DC'\r\nendfunction\r\n\r\nfunction Trig_MiracleBrewP_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId( GetOwningPlayer( GetLearningUnit() ) ) + 1\r\n    call SpellPotion(i, 15)\r\n    call spdst( GetLearningUnit(), 3 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MiracleBrewP takes nothing returns nothing\r\n    set gg_trg_MiracleBrewP = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MiracleBrewP, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_MiracleBrewP, Condition( function Trig_MiracleBrewP_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MiracleBrewP, function Trig_MiracleBrewP_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}