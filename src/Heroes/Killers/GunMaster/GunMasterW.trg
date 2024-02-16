{
  "Id": 50333128,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_GunMasterW_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel(GetOrderedUnit(), 'A19F') > 0\r\nendfunction\r\n\r\nfunction Trig_GunMasterW_Actions takes nothing returns nothing\r\n    local unit u = GetOrderedUnit()\r\n    local integer lvl = GetUnitAbilityLevel( u, 'A19F' )\r\n\r\n    if GetIssuedOrderId() == OrderId(\"immolation\") then\r\n        call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\ControlMagic\\\\ControlMagicTarget.mdl\", u, \"overhead\") )\r\n        call BlzSetUnitWeaponStringFieldBJ( u, UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART, 0, \".mdl\" )\r\n    elseif GetIssuedOrderId() == OrderId(\"unimmolation\") then\r\n        call BlzSetUnitWeaponStringFieldBJ( u, UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART, 0, \"Abilities\\\\Weapons\\\\Rifle\\\\RifleImpact.mdl\" )\r\n    endif\r\n    \r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_GunMasterW takes nothing returns nothing\r\n    set gg_trg_GunMasterW = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_GunMasterW, EVENT_PLAYER_UNIT_ISSUED_ORDER )\r\n    call TriggerAddCondition( gg_trg_GunMasterW, Condition( function Trig_GunMasterW_Conditions ) )\r\n    call TriggerAddAction( gg_trg_GunMasterW, function Trig_GunMasterW_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}