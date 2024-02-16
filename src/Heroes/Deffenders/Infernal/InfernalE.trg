{
  "Id": 50333034,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_InfernalE_Conditions takes nothing returns boolean\r\n    return GetLearnedSkill() == 'A1A5'\r\nendfunction\r\n\r\nfunction Trig_InfernalE_Actions takes nothing returns nothing\r\n    local unit u = GetLearningUnit()\r\n    local integer lvl = 3+GetUnitAbilityLevel(u, 'A1A5')\r\n    local integer id = GetHandleId(u)\r\n    \r\n    call UnitAddAbility( u, 'A1A6')\r\n    call UnitAddAbility( u, 'A1A7')\r\n    call SetUnitAbilityLevel(u, 'A1A6', lvl )\r\n    \r\n    call textst( \"|cFF57E5C6\" + I2S(GetUnitAbilityLevel(u, 'A1A6')-1), u, 64, GetRandomReal( 80, 100 ), 12, 1 )\r\n    call SaveReal( udg_hash, id, StringHash( \"infe\" ), 0 )\r\n    call SaveReal( udg_hash, id, StringHash( \"infen\" ), GetUnitState( u, UNIT_STATE_MAX_LIFE) * 0.2 )\r\n    \r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_InfernalE takes nothing returns nothing\r\n    set gg_trg_InfernalE = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_InfernalE, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_InfernalE, Condition( function Trig_InfernalE_Conditions ) )\r\n    call TriggerAddAction( gg_trg_InfernalE, function Trig_InfernalE_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}