{
  "Id": 50332220,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant integer MODE_REBORN_DAMAGE = 300\r\n    constant integer MODE_REBORN_RADIUS = 400\r\nendglobals\r\n\r\nfunction Trig_Reborn_Conditions takes nothing returns boolean\r\n    return IsUnitType( GetDyingUnit(), UNIT_TYPE_HERO) \r\nendfunction\r\n\r\nfunction Trig_Reborn_Actions takes nothing returns nothing  \r\n    call GroupAoE( GetDyingUnit(), null, GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ), MODE_REBORN_DAMAGE, MODE_REBORN_RADIUS, \"enemy\", \"Units\\\\Undead\\\\Abomination\\\\AbominationExplosion.mdl\", null )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Reborn takes nothing returns nothing\r\n    set gg_trg_Reborn = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Reborn )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Reborn, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Reborn, Condition( function Trig_Reborn_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Reborn, function Trig_Reborn_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}