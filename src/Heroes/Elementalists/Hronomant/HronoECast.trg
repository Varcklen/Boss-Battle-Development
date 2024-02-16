{
  "Id": 50333243,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_HronoECast_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel( GetSpellAbilityUnit(), 'A00P') > 0\r\nendfunction\r\n\r\nfunction Trig_HronoECast_Actions takes nothing returns nothing\r\n    local unit caster = GetSpellAbilityUnit()\r\n    local integer unitId = GetHandleId( caster )\r\n    local real c = LoadReal( udg_hash, unitId, StringHash( \"hrnec\" ) ) - CHRONOMANCER_E_REDUCTION\r\n\r\n    call SaveReal( udg_hash, unitId, StringHash( \"hrnec\" ), c )\r\n    call BlzStartUnitAbilityCooldown( caster, 'A00P', RMaxBJ( 1,c) )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_HronoECast takes nothing returns nothing\r\n    set gg_trg_HronoECast = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_HronoECast, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_HronoECast, Condition( function Trig_HronoECast_Conditions ) )\r\n    call TriggerAddAction( gg_trg_HronoECast, function Trig_HronoECast_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}