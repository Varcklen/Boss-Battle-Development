{
  "Id": 50332497,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PoliSub_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A14L'\r\nendfunction\r\n\r\nfunction Trig_PoliSub_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    local unit caster\r\n    local unit target\r\n    local integer x\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"enemy\", \"\", \"\", \"\", \"\" )\r\n        call textst( udg_string[0] + GetObjectName('A032'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n\r\n    set x = eyest( caster )\r\n    \r\n    if luckylogic( caster, 75, 1, 100 ) then\r\n        call UnitPoly( caster, target, 'n02L', 3 )\r\n    else\r\n        call UnitRemoveAbility( caster, 'BNsi')\r\n        call UnitPoly( caster, caster, 'n02L', 3 )\r\n    endif\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PoliSub takes nothing returns nothing\r\n    set gg_trg_PoliSub = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PoliSub, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_PoliSub, Condition( function Trig_PoliSub_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PoliSub, function Trig_PoliSub_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}