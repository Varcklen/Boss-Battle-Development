{
  "Id": 50333031,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Plate_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0G8' \r\nendfunction\r\n\r\nfunction Trig_Plate_Actions takes nothing returns nothing\r\n    local unit u = GetManipulatingUnit()\r\n\r\n    if GetUnitAbilityLevel(u, 'A1A5') > 0 then\r\n        call platest(u, 1 )\r\n        call healst( u, null, GetUnitState( u, UNIT_STATE_MAX_LIFE) * 0.05 )\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageDeathCaster.mdl\", GetItemX( GetManipulatedItem() ), GetItemY( GetManipulatedItem() ) ) )\r\n    else\r\n        set bj_lastCreatedItem = CreateItem('I0G8', GetItemX( GetManipulatedItem() ), GetItemY( GetManipulatedItem() ))\r\n    endif\r\n\r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Plate takes nothing returns nothing\r\n    set gg_trg_Plate = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Plate, EVENT_PLAYER_UNIT_PICKUP_ITEM )\r\n    call TriggerAddCondition( gg_trg_Plate, Condition( function Trig_Plate_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Plate, function Trig_Plate_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}