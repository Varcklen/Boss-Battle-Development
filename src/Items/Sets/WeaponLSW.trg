{
  "Id": 50332873,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_WeaponLSW_Conditions takes nothing returns boolean\r\n    return not( udg_logic[36] ) and GetItemTypeId(GetManipulatedItem()) == 'I030'\r\nendfunction\r\n\r\nfunction Trig_WeaponLSW_Actions takes nothing returns nothing\r\n    local unit n = GetManipulatingUnit()//udg_hero[GetPlayerId(GetOwningPlayer(GetManipulatingUnit())) + 1]\r\n    local integer i = CorrectPlayer(n)//GetPlayerId(GetOwningPlayer(n)) + 1\r\n    local integer cyclA = 0\r\n    \r\n    set udg_logic[i + 54] = false\r\n    if udg_Set_Weapon_Logic[i + 4] then\r\n        call UnitRemoveAbility( n, 'A05I')\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 12] then\r\n        call UnitRemoveAbility( n, 'A0P3')\r\n        call UnitRemoveAbility( n, 'A0P4')\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 16] then\r\n        call UnitRemoveAbility( n, 'A0YX')\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 20] then\r\n        call UnitRemoveAbility( n, 'A1DI')\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 24] then\r\n        call UnitRemoveAbility( n, 'A02A')\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 28] then\r\n        call UnitRemoveAbility( n, 'A0R2')\r\n        call UnitRemoveAbility( n, 'A0R3')\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 40] then\r\n        call UnitRemoveAbility( n, 'A0QX')\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 44] then\r\n        call UnitRemoveAbility( n, 'A11S' )\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 64] then\r\n        call UnitRemoveAbility( n, 'A0WH')\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 68] then\r\n        call UnitRemoveAbility( n, 'A0X7')\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 84] then\r\n        call UnitRemoveAbility( n, 'A175')\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 96] then\r\n        call spdst( n, 30 )\r\n    endif\r\n    if udg_Set_Weapon_Logic[i + 100] then\r\n        call spdst( n, -10 )\r\n        call UnitRemoveAbility( n, 'A18J')\r\n    endif\r\n    if not( udg_logic[52] ) then\r\n        call DisplayTimedTextToPlayer(GetOwningPlayer(n), 0, 0, 5., \"Set |cff2d9995Weapon|r is now disassembled!\")\r\n        call iconoff( i, \"Оружие\" )\r\n    endif\r\n    \r\n    \r\n    set Event_UnitLoseUltimateWeapon_Hero = n\r\n    set Event_UnitLoseUltimateWeapon_Item = GetManipulatedItem()\r\n    \r\n    set Event_UnitLoseUltimateWeapon_Real = 0.00\r\n    set Event_UnitLoseUltimateWeapon_Real = 1.00\r\n    set Event_UnitLoseUltimateWeapon_Real = 0.00\r\n    \r\n    set cyclA = 0\r\n    set udg_Set_Weapon_Number[i] = 0\r\n    loop\r\n        exitwhen cyclA > 5\r\n        if Weapon_Logic(UnitItemInSlot(n, cyclA)) then\r\n            set udg_Set_Weapon_Number[i] = udg_Set_Weapon_Number[i] + 1\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set n = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_WeaponLSW takes nothing returns nothing\r\n    set gg_trg_WeaponLSW = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_WeaponLSW, EVENT_PLAYER_UNIT_DROP_ITEM )\r\n    call TriggerAddCondition( gg_trg_WeaponLSW, Condition( function Trig_WeaponLSW_Conditions ) )\r\n    call TriggerAddAction( gg_trg_WeaponLSW, function Trig_WeaponLSW_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}