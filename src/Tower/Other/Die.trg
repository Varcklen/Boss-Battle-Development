{
  "Id": 50332263,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Die_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I00Z'\r\nendfunction\r\n\r\nfunction Trig_Die_Actions takes nothing returns nothing\r\n    local integer rand = GetRandomInt(1, 100 )\r\n    \r\n    if rand <= 33 then\r\n        call SetPlayerState( GetOwningPlayer( GetManipulatingUnit() ), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState( GetOwningPlayer( GetManipulatingUnit() ), PLAYER_STATE_RESOURCE_GOLD ) + 150 )\r\n        if GetUnitState( GetManipulatingUnit(), UNIT_STATE_LIFE ) > 0.405 and not( IsUnitLoaded( GetManipulatingUnit() ) ) then\r\n            call DestroyEffect(AddSpecialEffect( \"UI\\\\Feedback\\\\GoldCredit\\\\GoldCredit.mdl\", GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() ) ))\r\n            call textst( \"|c00FFFF00 +150\", GetManipulatingUnit(), 64, GetRandomReal(45, 135), 10, 1 )\r\n        endif\r\n        call textst( \"|c00757575 Congratulations\", udg_UNIT_HUKSTER, 64, 90, 8, 0.5 )\r\n    else\r\n        call textst( \"|c00757575 Try again\", udg_UNIT_HUKSTER, 64, 90, 8, 0.5 )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Die takes nothing returns nothing\r\n    set gg_trg_Die = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Die, EVENT_PLAYER_UNIT_PICKUP_ITEM ) \r\n    call TriggerAddCondition( gg_trg_Die, Condition( function Trig_Die_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Die, function Trig_Die_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}