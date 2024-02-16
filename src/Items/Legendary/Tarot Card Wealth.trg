{
  "Id": 50332735,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Tarot_Card_Wealth_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0D9'\r\nendfunction\r\n\r\nfunction Trig_Tarot_Card_Wealth_Actions takes nothing returns nothing\r\n    local unit u = GetManipulatingUnit()\r\n    local integer cyclA = 0\r\n    local item it\r\n    \r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    loop\r\n        exitwhen cyclA > 5\r\n\tset it = UnitItemInSlot( u, cyclA )\r\n        if it != null and GetItemType(it) != ITEM_TYPE_ARTIFACT and GetItemType(it) != ITEM_TYPE_POWERUP and GetItemType(it) != ITEM_TYPE_PURCHASABLE then\r\n            call Inventory_ReplaceItemByNew(u, UnitItemInSlot( u, cyclA ), ItemRandomizerItemId( u, \"legendary\" ))\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    call DestroyEffect( AddSpecialEffect( \"Objects\\\\Spawnmodels\\\\Human\\\\HCancelDeath\\\\HCancelDeath.mdl\", GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() ) ) )\r\n    \r\n    set u = null\r\n    set it = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Tarot_Card_Wealth takes nothing returns nothing\r\n    set gg_trg_Tarot_Card_Wealth = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Tarot_Card_Wealth, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Tarot_Card_Wealth, Condition( function Trig_Tarot_Card_Wealth_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Tarot_Card_Wealth, function Trig_Tarot_Card_Wealth_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}