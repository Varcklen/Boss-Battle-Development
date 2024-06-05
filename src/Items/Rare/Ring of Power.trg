{
  "Id": 50332664,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Ring_of_Power_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A144'\r\nendfunction\r\n\r\nfunction Trig_Ring_of_Power_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    local unit caster\r\n    local unit target\r\n    local real dmg\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"enemy\", RT_MINION, 0, 0 )\r\n        call textst( udg_string[0] + GetObjectName('A0EO'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n    \r\n    call AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\NightElf\\\\FaerieDragonInvis\\\\FaerieDragon_Invis.mdl\", target, \"head\")\r\n    call UnitApplyTimedLife( target, 'BTLF', 30.)\r\n    call SetUnitOwner( target, GetOwningPlayer( caster ), true )\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Ring_of_Power takes nothing returns nothing\r\n    set gg_trg_Ring_of_Power = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Ring_of_Power, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Ring_of_Power, Condition( function Trig_Ring_of_Power_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Ring_of_Power, function Trig_Ring_of_Power_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}