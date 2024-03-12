{
  "Id": 50332722,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PhoenixEgg_Conditions takes nothing returns boolean\r\n    return DeathSystem_IsUnkillable(GetDyingUnit()) == false and inv(GetDyingUnit(), 'I05U') > 0 and GetUnitAbilityLevel( GetDyingUnit(), 'B047' ) == 0 and not(LoadBoolean( udg_hash, GetHandleId( GetDyingUnit() ), StringHash( \"pheg\" ) ) ) and combat( GetDyingUnit(), false, 0 ) and not( IsUnitInGroup(GetDyingUnit(), udg_Return) ) and udg_Heroes_Ressurect_Battle <= 0 and GetPlayerSlotState(GetOwningPlayer(GetDyingUnit())) == PLAYER_SLOT_STATE_PLAYING\r\nendfunction\r\n\r\nfunction Trig_PhoenixEgg_Actions takes nothing returns nothing\r\n    set bj_lastCreatedUnit = CreateUnit( Player(PLAYER_NEUTRAL_AGGRESSIVE), 'h012', GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ), 270 )\r\n    call spectime(\"Abilities\\\\Spells\\\\Other\\\\BreathOfFire\\\\BreathOfFireMissile.mdl\", GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ), 1 )\r\n    call SaveUnitHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( \"fnx\" ), GetDyingUnit() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PhoenixEgg takes nothing returns nothing\r\n    set gg_trg_PhoenixEgg = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PhoenixEgg, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_PhoenixEgg, Condition( function Trig_PhoenixEgg_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PhoenixEgg, function Trig_PhoenixEgg_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}