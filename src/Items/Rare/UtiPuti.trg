{
  "Id": 50332694,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_UtiPuti_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I08J'\r\nendfunction\r\n\r\nfunction Trig_UtiPuti_Actions takes nothing returns nothing\r\n    call NewUniques( GetManipulatingUnit(), 'A00N' )\r\n    call DestroyEffect( AddSpecialEffect( \"Objects\\\\Spawnmodels\\\\Demon\\\\DemonSmallDeathExplode\\\\DemonSmallDeathExplode.mdl\", GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() ) ) )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_UtiPuti takes nothing returns nothing\r\n    set gg_trg_UtiPuti = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_UtiPuti, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_UtiPuti, Condition( function Trig_UtiPuti_Conditions ) )\r\n    call TriggerAddAction( gg_trg_UtiPuti, function Trig_UtiPuti_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}