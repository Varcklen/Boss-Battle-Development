{
  "Id": 50332903,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Innervate_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A19N'\r\nendfunction\r\n\r\nfunction Trig_Innervate_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    local real heal\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"ally\", \"notfull\", \"\", \"\", \"\" )\r\n        call textst( udg_string[0] + GetObjectName('A19N'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n    \r\n    set heal = 150\r\n    \r\n    if GetUnitState( target, UNIT_STATE_LIFE) <= 0.4*GetUnitState( target, UNIT_STATE_MAX_LIFE) then\r\n        call shield( caster, target, heal )\r\n    endif\r\n    \r\n    call healst( caster, target, heal )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Objects\\\\Spawnmodels\\\\NightElf\\\\EntBirthTarget\\\\EntBirthTarget.mdl\" , target, \"origin\" ) )\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Innervate takes nothing returns nothing\r\n    set gg_trg_Innervate = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Innervate, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Innervate, Condition( function Trig_Innervate_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Innervate, function Trig_Innervate_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}