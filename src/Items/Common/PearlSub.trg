{
  "Id": 50332495,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PearlSub_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A140'\r\nendfunction\r\n\r\nfunction Trig_PearlSub_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd \r\n    local real heal\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"ally\", RT_NOT_FULL_HEALTH, 0, 0 )\r\n        call textst( udg_string[0] + GetObjectName('A0E2'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n\r\n    set heal = 100. + ( 25. * GetHeroLevel( caster ) ) \r\n    set cyclAEnd = eyest( caster )\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call healst( caster, target, heal )\r\n        call DestroyEffect( AddSpecialEffectTarget( \"war3mapImported\\\\MiniRessurection.mdx\", target, \"origin\" ) )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PearlSub takes nothing returns nothing\r\n    set gg_trg_PearlSub = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PearlSub, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_PearlSub, Condition( function Trig_PearlSub_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PearlSub, function Trig_PearlSub_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}