{
  "Id": 50333129,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_GunMasterE_Conditions takes nothing returns boolean\r\n     return udg_DamageEventAmount > 0 and combat( udg_DamageEventSource, false, 0 ) and luckylogic( udg_DamageEventSource, 2*GetUnitAbilityLevel( udg_hero[GetPlayerId( GetOwningPlayer(udg_DamageEventSource) ) + 1], 'A19J'), 1, 100 ) and GetUnitAbilityLevel(udg_hero[GetPlayerId( GetOwningPlayer(udg_DamageEventSource) ) + 1], 'A19J') > 0 and ( GetUnitTypeId(udg_DamageEventSource) == 'u000' or udg_DamageEventSource == udg_hero[GetPlayerId( GetOwningPlayer(udg_DamageEventSource) ) + 1] ) and not(IsUnitType( udg_DamageEventTarget, UNIT_TYPE_HERO))\r\nendfunction\r\n\r\nfunction Trig_GunMasterE_Actions takes nothing returns nothing\r\n    local unit target = udg_DamageEventTarget\r\n    \r\n    if GetUnitState( target, UNIT_STATE_LIFE) > 0.405 then\r\n        call BlzSetUnitArmor( target, BlzGetUnitArmor(target) - 1 )\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Weapons\\\\GyroCopter\\\\GyroCopterMissile.mdl\", GetUnitX( target ), GetUnitY( target ) ) )\r\n    endif\r\n\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_GunMasterE takes nothing returns nothing\r\n    set gg_trg_GunMasterE = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_GunMasterE, \"udg_DamageModifierEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_GunMasterE, Condition( function Trig_GunMasterE_Conditions ) )\r\n    call TriggerAddAction( gg_trg_GunMasterE, function Trig_GunMasterE_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}