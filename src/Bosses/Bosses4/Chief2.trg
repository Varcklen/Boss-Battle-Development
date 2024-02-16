{
  "Id": 50333503,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Chief2_Conditions takes nothing returns boolean\r\n    return IsUnitInGroup(GetDyingUnit(), udg_heroinfo) and udg_combatlogic[GetPlayerId(GetOwningPlayer(GetDyingUnit())) + 1] and udg_fightmod[0] and CountLivingPlayerUnitsOfTypeId('h01X', Player(10)) > 0\r\nendfunction\r\n\r\nfunction Trig_Chief2_Actions takes nothing returns nothing\r\n    local group g = CreateGroup()\r\n    local unit n\r\n\r\n        set bj_livingPlayerUnitsTypeId = 'h01X'\r\n        call GroupEnumUnitsOfPlayer(g, Player(10), filterLivingPlayerUnitsOfTypeId)\r\n        loop\r\n            set n = FirstOfGroup(g)\r\n            exitwhen n == null\r\n            call SetUnitState( n, UNIT_STATE_LIFE, GetUnitState( n, UNIT_STATE_LIFE) + ( GetUnitState( n, UNIT_STATE_MAX_LIFE)*0.1*SpellPower_GetBossSpellPower() ) )\r\n            call DestroyEffect( AddSpecialEffect(\"Abilities\\\\Spells\\\\Undead\\\\AnimateDead\\\\AnimateDeadTarget.mdl\", GetUnitX( n ), GetUnitY( n ) ) )\r\n            call GroupRemoveUnit(g,n)\r\n            set n = FirstOfGroup(g)\r\n        endloop\r\n\r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set n = null\r\n    set g = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Chief2 takes nothing returns nothing\r\n    set gg_trg_Chief2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Chief2 )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Chief2, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Chief2, Condition( function Trig_Chief2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Chief2, function Trig_Chief2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}