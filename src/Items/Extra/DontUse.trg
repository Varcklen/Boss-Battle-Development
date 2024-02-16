{
  "Id": 50332842,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function VampLogic takes nothing returns boolean\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd = udg_Database_InfoNumberHeroes\r\n    local boolean l = false\r\n\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        if GetLearnedSkill() == udg_DB_Hero_FirstSpell[cyclA] then\r\n            set l = true\r\n            set cyclA = cyclAEnd\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    return l\r\nendfunction\r\n\r\nfunction Trig_DontUse_Conditions takes nothing returns boolean\r\n    if inv(GetLearningUnit(), 'I004') > 0 and VampLogic() then\r\n        return true\r\n    endif\r\n    return false\r\nendfunction\r\n\r\nfunction Trig_DontUse_Actions takes nothing returns nothing\r\n    call UnitRemoveAbility( GetLearningUnit(), GetLearnedSkill() )\r\n    call UnitModifySkillPoints( GetLearningUnit(), 1 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DontUse takes nothing returns nothing\r\n    set gg_trg_DontUse = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_DontUse, EVENT_PLAYER_HERO_SKILL )\r\n    call TriggerAddCondition( gg_trg_DontUse, Condition( function Trig_DontUse_Conditions ) )\r\n    call TriggerAddAction( gg_trg_DontUse, function Trig_DontUse_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}