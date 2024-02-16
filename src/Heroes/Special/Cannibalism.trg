{
  "Id": 50332920,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cannibalism_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A1BL'\r\nendfunction\r\n\r\nfunction Trig_Cannibalism_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Target\r\n        set target = null\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"ally\", \"pris\", \"\", \"\", \"\" )\r\n        call textst( udg_string[0] + GetObjectName('A1BL'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n    \r\n    call DestroyEffect( AddSpecialEffect( \"Blood Whirl.mdx\", GetUnitX( target ), GetUnitY( target ) ) )\r\n    call healst(caster, null, GetUnitState( target, UNIT_STATE_MAX_LIFE) * 1.1)\r\n\tcall KillUnit(target)\r\n    \r\n    set target = null\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cannibalism takes nothing returns nothing\r\n    set gg_trg_Cannibalism = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Cannibalism, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Cannibalism, Condition( function Trig_Cannibalism_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Cannibalism, function Trig_Cannibalism_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}