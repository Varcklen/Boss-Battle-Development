{
  "Id": 50332911,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Burst_of_Energy_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A1AF'\r\nendfunction\r\n\r\nfunction Trig_Burst_of_Energy_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    local real mana\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"ally\", 0, 0, 0 )\r\n        call textst( udg_string[0] + GetObjectName('A1AF'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n    \r\n    set mana = 35\r\n    \r\n    if GetUnitAbilityLevel( target, 'B05P') > 0 then\r\n        set mana = mana*2\r\n    endif\r\n    \r\n    call manast( caster, target, mana )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Undead\\\\FreezingBreath\\\\FreezingBreathMissile.mdl\" , target, \"origin\" ) )\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Burst_of_Energy takes nothing returns nothing\r\n    set gg_trg_Burst_of_Energy = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Burst_of_Energy, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Burst_of_Energy, Condition( function Trig_Burst_of_Energy_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Burst_of_Energy, function Trig_Burst_of_Energy_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}