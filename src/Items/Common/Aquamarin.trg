{
  "Id": 50332387,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Aquamarin_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0GL'\r\nendfunction\r\n\r\nfunction Trig_Aquamarin_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n\r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"ally\", RT_HERO, 0, 0 )\r\n        call textst( udg_string[0] + GetObjectName('A11H'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n\r\n    set cyclAEnd = eyest( caster )\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call shield( caster, target, 300 )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Aquamarin takes nothing returns nothing\r\n    set gg_trg_Aquamarin = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Aquamarin, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Aquamarin, Condition( function Trig_Aquamarin_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Aquamarin, function Trig_Aquamarin_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}