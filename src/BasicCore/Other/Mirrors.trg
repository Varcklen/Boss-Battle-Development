{
  "Id": 50332196,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Mirrors_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetDyingUnit()) == 'n04P' or GetUnitTypeId(GetDyingUnit()) == 'e003'\r\nendfunction\r\n\r\nfunction Trig_Mirrors_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageDeathCaster.mdl\", GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ) ) )\r\n    call ShowUnit( GetDyingUnit(), false)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Mirrors takes nothing returns nothing\r\n    set gg_trg_Mirrors = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Mirrors, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Mirrors, Condition( function Trig_Mirrors_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Mirrors, function Trig_Mirrors_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}