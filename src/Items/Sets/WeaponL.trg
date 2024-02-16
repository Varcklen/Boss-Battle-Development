{
  "Id": 50332871,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_WeaponL_Conditions takes nothing returns boolean\r\n    if udg_logic[36] then\r\n        return false\r\n    endif\r\n    if not( Weapon_Logic(GetManipulatedItem()) ) then\r\n        return false\r\n    endif\r\n    if udg_logic[GetPlayerId(GetOwningPlayer(GetManipulatingUnit())) + 1 + 54] then\r\n        return false\r\n    endif\r\n    return true\r\nendfunction\r\n\r\nfunction Trig_WeaponL_Actions takes nothing returns nothing\r\n    local unit n = GetManipulatingUnit()//udg_hero[GetPlayerId(GetOwningPlayer(GetManipulatingUnit())) + 1]\r\n    local integer i = CorrectPlayer(n)//GetPlayerId(GetOwningPlayer(n)) + 1\r\n\r\n    set udg_Set_Weapon_Number[i] = udg_Set_Weapon_Number[i] - 1\r\n    \r\n    set Event_UnitLoseWeapon_Hero = n\r\n    set Event_UnitLoseWeapon_Item = GetManipulatedItem()\r\n    \r\n    set Event_UnitLoseWeapon_Real = 0.00\r\n    set Event_UnitLoseWeapon_Real = 1.00\r\n    set Event_UnitLoseWeapon_Real = 0.00\r\n    \r\n    //call AllSetRing( n, 7, GetManipulatedItem() )\r\n    \r\n    set n = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_WeaponL takes nothing returns nothing\r\n    set gg_trg_WeaponL = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_WeaponL, EVENT_PLAYER_UNIT_DROP_ITEM )\r\n    call TriggerAddCondition( gg_trg_WeaponL, Condition( function Trig_WeaponL_Conditions ) )\r\n    call TriggerAddAction( gg_trg_WeaponL, function Trig_WeaponL_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}