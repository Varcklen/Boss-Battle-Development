{
  "Id": 50333276,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PeacelockE_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A04X'\r\nendfunction\r\n\r\nfunction Trig_PeacelockE_Actions takes nothing returns nothing\r\n\tset udg_real[2] = 0.25 + (0.15*GetUnitAbilityLevel( GetLearningUnit(), 'A04X'))\r\n    set udg_unit[0] = GetLearningUnit()\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PeacelockE takes nothing returns nothing\r\n    set gg_trg_PeacelockE = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PeacelockE, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_PeacelockE, Condition( function Trig_PeacelockE_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PeacelockE, function Trig_PeacelockE_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}