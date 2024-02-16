{
  "Id": 50333076,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MarshalEKillEnd_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel( udg_FightEnd_Unit, 'A0F7') > 0 and GetUnitAbilityLevel( udg_FightEnd_Unit, 'A0G0') > 0 and not(udg_fightmod[3])\r\nendfunction\r\n\r\nfunction Trig_MarshalEKillEnd_Actions takes nothing returns nothing\r\n    local integer lvl = GetUnitAbilityLevel( udg_FightEnd_Unit, 'A0F7')\r\n    local integer bonus = lvl\r\n    \r\n    if LoadInteger( udg_hash, GetHandleId( udg_FightEnd_Unit ), StringHash( \"kill\" ) ) == 0 then\r\n        set bonus = bonus * 2\r\n    endif\r\n    \r\n    call UnitRemoveAbility(udg_FightEnd_Unit, 'A0G0')\r\n    call UnitRemoveAbility(udg_FightEnd_Unit, 'B06B')\r\n    call statst( udg_FightEnd_Unit, bonus, bonus, 0, 0, true )\r\n    call textst( \"Humanity rises! +\" + I2S(bonus), udg_FightEnd_Unit, 64, GetRandomInt( 45, 135 ), 10, 4 )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\ReviveHuman\\\\ReviveHuman.mdl\", udg_FightEnd_Unit, \"origin\" ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MarshalEKillEnd takes nothing returns nothing\r\n    set gg_trg_MarshalEKillEnd = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_MarshalEKillEnd, \"udg_FightEnd_Real\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_MarshalEKillEnd, Condition( function Trig_MarshalEKillEnd_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MarshalEKillEnd, function Trig_MarshalEKillEnd_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}