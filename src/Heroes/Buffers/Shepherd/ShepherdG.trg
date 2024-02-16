{
  "Id": 50333062,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope ShepherdG initializer init\r\n\r\n    globals\r\n        private constant integer ID_ABILITY_LEARNED = 'A1DV'\r\n        private constant integer ID_ABILITY_GAINED = 'A1DP'\r\n    endglobals\r\n    \r\n    function Trig_ShepherdG_Conditions takes nothing returns boolean\r\n        return GetLearnedSkill() == ID_ABILITY_LEARNED\r\n    endfunction\r\n\r\n    function Trig_ShepherdG_Actions takes nothing returns nothing\r\n        local integer lvl\r\n        local unit learner\r\n        \r\n        set learner = GetLearningUnit()\r\n        set lvl = GetUnitAbilityLevel( learner, ID_ABILITY_LEARNED )\r\n        call UnitRemoveAbilityBJ( ID_ABILITY_GAINED, learner )\r\n        call UnitAddAbilityBJ( ID_ABILITY_GAINED, learner )\r\n        call SetUnitAbilityLevel( learner, ID_ABILITY_GAINED, lvl )\r\n        set learner = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        set gg_trg_ShepherdG = CreateTrigger(  )\r\n        call TriggerRegisterAnyUnitEventBJ( gg_trg_ShepherdG, EVENT_PLAYER_HERO_SKILL )\r\n        call TriggerAddCondition( gg_trg_ShepherdG, Condition( function Trig_ShepherdG_Conditions ) )\r\n        call TriggerAddAction( gg_trg_ShepherdG, function Trig_ShepherdG_Actions )\r\n    endfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}