{
  "Id": 50333091,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SniperRH_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I05T'\r\nendfunction\r\n\r\nfunction Trig_SniperRH_Actions takes nothing returns nothing\r\n    call healst( LoadUnitHandle( udg_hash, GetHandleId( GetManipulatedItem() ), StringHash( \"snpr\" ) ), GetManipulatingUnit(), LoadReal( udg_hash, GetHandleId( GetManipulatedItem() ), StringHash( \"snpr\" ) ) )\r\n    call RemoveSavedHandle(udg_hash, GetHandleId( GetManipulatedItem() ), StringHash( \"snpr\" ) )\r\n    call RemoveSavedReal(udg_hash, GetHandleId( GetManipulatedItem() ), StringHash( \"snpr\" ) )\r\n    call spectimeunit( GetManipulatingUnit(), \"Abilities\\\\Spells\\\\Human\\\\Heal\\\\HealTarget.mdl\", \"origin\", 2 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SniperRH takes nothing returns nothing\r\n    set gg_trg_SniperRH = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_SniperRH, EVENT_PLAYER_UNIT_PICKUP_ITEM )\r\n    call TriggerAddCondition( gg_trg_SniperRH, Condition( function Trig_SniperRH_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SniperRH, function Trig_SniperRH_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}