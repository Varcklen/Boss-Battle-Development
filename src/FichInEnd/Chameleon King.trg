{
  "Id": 50333716,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Chameleon_King_Conditions takes nothing returns boolean\r\n    return SubString(BlzGetItemExtendedTooltip(GetManipulatedItem()), 0, 19) == \"|cFFFFFF7DChameleon\" and combat( GetManipulatingUnit(), false, 0 )\r\nendfunction\r\n\r\nfunction Trig_Chameleon_King_Actions takes nothing returns nothing\r\n    local item it = GetManipulatedItem()\r\n    local unit u = GetManipulatingUnit()\r\n\r\n    if GetUnitState( u, UNIT_STATE_LIFE) > 0.405 then\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( u ), GetUnitY( u ) ) )\r\n        call Inventory_ReplaceItemByNew(u, it, udg_DB_Item_Activate[GetRandomInt( 1, udg_Database_NumberItems[31] )])\r\n    endif\r\n    \r\n    set it = null\r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Chameleon_King takes nothing returns nothing\r\n    set gg_trg_Chameleon_King = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Chameleon_King, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Chameleon_King, Condition( function Trig_Chameleon_King_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Chameleon_King, function Trig_Chameleon_King_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}