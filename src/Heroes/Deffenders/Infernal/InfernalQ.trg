{
  "Id": 50333032,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_InfernalQ_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A1A8'\r\nendfunction\r\n\r\nfunction Trig_InfernalQ_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    local integer lvl\r\n    local real heal\r\n    local item it\r\n    local boolean l = false\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = caster\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A1A8'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif\r\n    \r\n    set heal = 200 + (75*lvl)\r\n    set it = GetSpellTargetItem()\r\n    \r\n    if GetItemTypeId(it) == 'I0G8' then\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageDeathCaster.mdl\", GetItemX( it ), GetItemY( it ) ) )\r\n        call RemoveItem(it)\r\n        set l = true\r\n    elseif GetUnitAbilityLevel(caster, 'A1A6') > 1 then\r\n        call platest(caster, -1 )\r\n        set l = true\r\n    endif\r\n\r\n    if l then\r\n        call healst( caster, target, heal )\r\n        call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\NightElf\\\\ManaBurn\\\\ManaBurnTarget.mdl\", target, \"origin\") )\r\n    endif\r\n    \r\n    set caster = null\r\n    set target = null\r\n    set it = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_InfernalQ takes nothing returns nothing\r\n    set gg_trg_InfernalQ = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_InfernalQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_InfernalQ, Condition( function Trig_InfernalQ_Conditions ) )\r\n    call TriggerAddAction( gg_trg_InfernalQ, function Trig_InfernalQ_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}