{
  "Id": 50333592,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Spider3_Conditions takes nothing returns boolean\r\n    return IsUnitInGroup(GetDyingUnit(), udg_heroinfo) and udg_combatlogic[GetPlayerId(GetOwningPlayer(GetDyingUnit())) + 1] and udg_fightmod[0]\r\nendfunction\r\n\r\nfunction Trig_Spider3_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    \r\n    if CountLivingPlayerUnitsOfTypeId('n01X', Player(10)) > 0 then\r\n        loop\r\n            exitwhen cyclA > 4\r\n            if CountLivingPlayerUnitsOfTypeId('n01Y', Player(10)) <= 35 then\r\n                set bj_lastCreatedUnit = CreateUnit( Player(10), 'n01Y', GetUnitX( GetDyingUnit() ) + GetRandomReal( -200, 200 ), GetUnitY( GetDyingUnit() ) + GetRandomReal( -200, 200 ), GetRandomReal( 0, 360 ) )\r\n                call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\AnimateDead\\\\AnimateDeadTarget.mdl\", bj_lastCreatedUnit, \"origin\") )\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Spider3 takes nothing returns nothing\r\n    set gg_trg_Spider3 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Spider3 )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Spider3, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Spider3, Condition( function Trig_Spider3_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Spider3, function Trig_Spider3_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}