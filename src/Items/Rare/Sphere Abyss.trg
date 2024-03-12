{
  "Id": 50332676,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sphere_Abyss_Conditions takes nothing returns boolean\r\n    return DeathSystem_IsUnkillable(GetDyingUnit()) == false and GetUnitAbilityLevel(GetDyingUnit(), 'B047') == 0 and inv(GetDyingUnit(), 'I0AQ') > 0 and udg_Heroes_Amount > 1 and udg_number[GetPlayerId(GetOwningPlayer(GetDyingUnit())) + 1 + 78] == 0 and combat( GetDyingUnit(), false, 0 ) and not( udg_fightmod[3] ) and not( IsUnitInGroup(GetDyingUnit(), udg_Return) ) and udg_Heroes_Ressurect_Battle <= 0 and GetPlayerSlotState(GetOwningPlayer(GetDyingUnit())) == PLAYER_SLOT_STATE_PLAYING\r\nendfunction \r\n\r\nfunction Trig_Sphere_Abyss_Actions takes nothing returns nothing\r\n    set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( GetDyingUnit() ), 'h01M', GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ), 270 )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Other\\\\HowlOfTerror\\\\HowlCaster.mdl\", GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ) ) )\r\n    call SaveInteger( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( \"sfab\" ), GetPlayerId(GetOwningPlayer(GetDyingUnit())) + 1 )\r\n    call SaveUnitHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( \"sfab\" ), bj_lastCreatedUnit )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sphere_Abyss takes nothing returns nothing\r\n    set gg_trg_Sphere_Abyss = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Sphere_Abyss, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Sphere_Abyss, Condition( function Trig_Sphere_Abyss_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Sphere_Abyss, function Trig_Sphere_Abyss_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}