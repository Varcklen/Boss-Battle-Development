{
  "Id": 50332930,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant integer MULTICAST_BONUS = 1\r\n    \r\n    integer array Multicast_Bonus[5]\r\nendglobals\r\n\r\nfunction Trig_Multicast_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0GT' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )\r\nendfunction\r\n\r\nfunction Trig_Multicast_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local integer index\r\n    local integer bonus = 0\r\n    local integer i\r\n\r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0GT'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    set index = GetUnitUserData(caster)\r\n\r\n    set i = 1\r\n    loop\r\n        exitwhen i > SETS_COUNT\r\n        if SetCount_GetPieces(caster, i) > 0 then\r\n            set bonus = bonus + MULTICAST_BONUS\r\n        endif\r\n        set i = i + 1\r\n    endloop\r\n    \r\n    call BlzSetUnitBaseDamage( caster, BlzGetUnitBaseDamage(caster, 0) + bonus, 0 )\r\n    call spdst(caster, bonus)\r\n    set Multicast_Bonus[index] = Multicast_Bonus[index] + bonus\r\n    \r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\UnholyFrenzyAOE\\\\UnholyFrenzyAOETarget.mdl\", caster, \"origin\" ) )\r\n\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Multicast takes nothing returns nothing\r\n    set gg_trg_Multicast = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Multicast, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Multicast, Condition( function Trig_Multicast_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Multicast, function Trig_Multicast_Actions )\r\nendfunction\r\n\r\nscope Multicast initializer Triggs\r\n    private function StartFight_Conditions takes nothing returns boolean\r\n        return Multicast_Bonus[GetUnitUserData(udg_FightEnd_Unit)] > 0\r\n    endfunction\r\n    \r\n    private function StartFight takes nothing returns nothing\r\n        local unit hero = udg_FightEnd_Unit\r\n        local integer index = GetUnitUserData(hero)\r\n\r\n        call BlzSetUnitBaseDamage( hero, BlzGetUnitBaseDamage(hero, 0) - Multicast_Bonus[index], 0 )\r\n        call spdst(hero, -Multicast_Bonus[index])\r\n        set Multicast_Bonus[index] = 0\r\n        \r\n        set hero = null\r\n    endfunction\r\n\r\n    private function Triggs takes nothing returns nothing\r\n        local trigger trig = CreateTrigger()\r\n\r\n        call TriggerRegisterVariableEvent( trig, \"udg_FightEnd_Real\", EQUAL, 1.00 )\r\n        call TriggerAddCondition( trig, Condition( function StartFight_Conditions ) )\r\n        call TriggerAddAction( trig, function StartFight)\r\n        \r\n        set trig = null\r\n    endfunction\r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}