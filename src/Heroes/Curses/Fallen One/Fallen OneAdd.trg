{
  "Id": 50333378,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Fallen_OneAdd_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A02T'\r\nendfunction\r\n\r\nfunction Trig_Fallen_OneAdd_Actions takes nothing returns nothing\r\n    local integer lvl = GetUnitAbilityLevel(GetLearningUnit(), 'A02T')\r\n    if lvl > 4 then\r\n        set lvl = 4\r\n    endif\r\n\r\n    call UnitAddAbility( GetLearningUnit(), 'A08S')\r\n    set udg_FallenOneDamage = 3 + (3*lvl)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Fallen_OneAdd takes nothing returns nothing\r\n    set gg_trg_Fallen_OneAdd = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Fallen_OneAdd, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_Fallen_OneAdd, Condition( function Trig_Fallen_OneAdd_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Fallen_OneAdd, function Trig_Fallen_OneAdd_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}