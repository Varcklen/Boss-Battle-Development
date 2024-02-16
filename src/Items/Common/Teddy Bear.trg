{
  "Id": 50332544,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Teddy_Bear_Conditions takes nothing returns boolean\r\n    return GetUnitState( udg_Event_PlayerMinionSummon_Hero, UNIT_STATE_LIFE) > 0.405 and inv( udg_Event_PlayerMinionSummon_Hero, 'I08V' ) > 0\r\nendfunction\r\n\r\nfunction Trig_Teddy_Bear_Actions takes nothing returns nothing\r\n    local unit myUnit = udg_Event_PlayerMinionSummon_Unit\r\n\tlocal real hp = BlzGetUnitMaxHP(myUnit)\r\n    \r\n    call BlzSetUnitBaseDamage( myUnit, BlzGetUnitBaseDamage(myUnit, 0) + 5, 0 )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\Slow\\\\SlowCaster.mdl\", myUnit, \"overhead\" ) )\r\n    if GetUnitTypeId(myUnit) == ID_SHEEP then\r\n    \tcall BlzSetUnitMaxHP( myUnit, R2I(BlzGetUnitMaxHP(myUnit) + hp ) )\r\n        call SetUnitLifeBJ( myUnit, GetUnitState(myUnit, UNIT_STATE_LIFE) + R2I(hp) )\r\n    \tcall BlzSetUnitBaseDamage( myUnit, R2I(GetUnitDamage(myUnit) * 2)-GetUnitAvgDiceDamage(myUnit), 0 )\r\n    endif\r\n    \r\n    set myUnit = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Teddy_Bear takes nothing returns nothing\r\n    set gg_trg_Teddy_Bear = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Teddy_Bear, \"udg_Event_PlayerMinionSummon_Real\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Teddy_Bear, Condition( function Trig_Teddy_Bear_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Teddy_Bear, function Trig_Teddy_Bear_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}