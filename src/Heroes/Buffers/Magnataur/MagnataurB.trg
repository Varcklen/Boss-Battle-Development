{
  "Id": 50332949,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MagnataurB_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A0UF' or GetLearnedSkill() == 'A0VG' or GetLearnedSkill() == 'A0WJ'\r\nendfunction\r\n\r\nfunction Trig_MagnataurB_Actions takes nothing returns nothing\r\n    if GetLearnedSkill() == 'A0UF' then\r\n        call UnitRemoveAbility( GetLearningUnit(), 'A0BJ')\r\n        call UnitRemoveAbility( GetLearningUnit(), 'B03M')\r\n        call UnitAddAbility( GetLearningUnit(), 'A0BJ')\r\n        call SetUnitAbilityLevel( GetLearningUnit(), 'A0BC', GetUnitAbilityLevel( GetLearningUnit(), GetLearnedSkill() ) )\r\n    elseif GetLearnedSkill() == 'A0VG' then\r\n        call UnitRemoveAbility( GetLearningUnit(), 'A0AV')\r\n        call UnitRemoveAbility( GetLearningUnit(), 'B03N')\r\n        call UnitAddAbility( GetLearningUnit(), 'A0AV')\r\n        call SetUnitAbilityLevel( GetLearningUnit(), 'A0A8', GetUnitAbilityLevel( GetLearningUnit(), GetLearnedSkill() ) )\r\n    else\r\n        call UnitRemoveAbility( GetLearningUnit(), 'A0B3')\r\n        call UnitRemoveAbility( GetLearningUnit(), 'B03P')\r\n        call UnitAddAbility( GetLearningUnit(), 'A0B3')\r\n        call SetUnitAbilityLevel( GetLearningUnit(), 'A0N6', GetUnitAbilityLevel( GetLearningUnit(), GetLearnedSkill() ) )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MagnataurB takes nothing returns nothing\r\n    set gg_trg_MagnataurB = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MagnataurB, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_MagnataurB, Condition( function Trig_MagnataurB_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MagnataurB, function Trig_MagnataurB_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}