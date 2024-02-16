{
  "Id": 50333257,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_EnergyballA_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventSource) == 'N039'\r\nendfunction\r\n\r\nfunction EnergyballACast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    call DestroyLightning( LoadLightningHandle( udg_hash, id, StringHash( \"enba\" ) ) )\r\n    call FlushChildHashtable( udg_hash, id )\r\nendfunction\r\n\r\nfunction Trig_EnergyballA_Actions takes nothing returns nothing\r\n    local lightning l = AddLightningEx(\"CLPB\", true, GetUnitX(udg_DamageEventSource), GetUnitY(udg_DamageEventSource), GetUnitFlyHeight(udg_DamageEventSource) + 50, GetUnitX(udg_DamageEventTarget), GetUnitY(udg_DamageEventTarget), GetUnitFlyHeight(udg_DamageEventTarget) + 50 )\r\n    local integer id = GetHandleId( l )\r\n\r\n    call SaveTimerHandle( udg_hash, id, StringHash( \"enba\" ), CreateTimer() )\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"enba\" ) ) ) \r\n\tcall SaveLightningHandle( udg_hash, id, StringHash( \"enba\" ), l )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( l ), StringHash( \"enba\" ) ), 0.5, false, function EnergyballACast )\r\n    \r\n    set l = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_EnergyballA takes nothing returns nothing\r\n    set gg_trg_EnergyballA = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_EnergyballA, \"udg_DamageModifierEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_EnergyballA, Condition( function Trig_EnergyballA_Conditions ) )\r\n    call TriggerAddAction( gg_trg_EnergyballA, function Trig_EnergyballA_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}