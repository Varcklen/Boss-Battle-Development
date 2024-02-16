{
  "Id": 50332619,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_JagotCast_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == JAGOT_CLOCK_ID\r\nendfunction\r\n\r\nfunction Trig_JagotCast_Actions takes nothing returns nothing\r\n    call UnitReduceCooldown(GetManipulatingUnit(), JAGOT_COOLDOWN_REDUCTION)\r\n    call DestroyEffect( AddSpecialEffect( JAGOT_ANIMATION, GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() ) ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_JagotCast takes nothing returns nothing\r\n    set gg_trg_JagotCast = CreateTrigger()\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_JagotCast, EVENT_PLAYER_UNIT_PICKUP_ITEM )\r\n    call TriggerAddCondition( gg_trg_JagotCast, Condition( function Trig_JagotCast_Conditions ) )\r\n    call TriggerAddAction( gg_trg_JagotCast, function Trig_JagotCast_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}