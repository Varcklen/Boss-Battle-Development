{
  "Id": 50332231,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Flame_Conditions takes nothing returns boolean\r\n    return IsUnitInGroup(GetSpellAbilityUnit(), udg_heroinfo)\r\nendfunction\r\n\r\nfunction Trig_Flame_Actions takes nothing returns nothing\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    \r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Other\\\\Incinerate\\\\FireLordDeathExplode.mdl\", GetSpellAbilityUnit(), \"origin\" ) )\r\n    call dummyspawn( GetSpellAbilityUnit(), 1, 0, 0, 0 )\r\n    call GroupEnumUnitsInRange( g, GetUnitX( GetSpellAbilityUnit() ), GetUnitY( GetSpellAbilityUnit() ), 250, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        if unitst( u, GetSpellAbilityUnit(), \"ally\" ) and u != GetSpellAbilityUnit() then\r\n            call UnitDamageTarget( bj_lastCreatedUnit, u, 25, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n    endloop\r\n    \r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Flame takes nothing returns nothing\r\n    set gg_trg_Flame = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Flame )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Flame, EVENT_PLAYER_UNIT_SPELL_FINISH )\r\n    call TriggerAddCondition( gg_trg_Flame, Condition( function Trig_Flame_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Flame, function Trig_Flame_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}