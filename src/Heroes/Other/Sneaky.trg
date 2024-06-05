{
  "Id": 50332945,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sneaky_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0C8'\r\nendfunction\r\n\r\nfunction Trig_Sneaky_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    local integer id \r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"ally\", 0, 0, 0 )\r\n        call textst( udg_string[0] + GetObjectName('A0C8'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n    \r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Invisibility\\\\InvisibilityTarget.mdl\", GetUnitX( target ), GetUnitY( target ) ) )\r\n    \r\n    call InvisibilitySystem_Apply(caster, target, 10)\r\n    //call dummyspawn( caster, 1, 'A0CQ', 0, 0 )\r\n    //call shadowst( target )\r\n    //call IssueTargetOrder( bj_lastCreatedUnit, \"invisibility\", target )\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sneaky takes nothing returns nothing\r\n    set gg_trg_Sneaky = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Sneaky, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Sneaky, Condition( function Trig_Sneaky_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Sneaky, function Trig_Sneaky_Actions )\r\nendfunction\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}