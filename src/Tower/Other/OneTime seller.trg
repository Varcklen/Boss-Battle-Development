{
  "Id": 50332270,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_OneTime_seller_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetSellingUnit()) == 'n031'\r\nendfunction\r\n\r\nfunction Trig_OneTime_seller_Actions takes nothing returns nothing\r\n    call DestroyEffect(AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageDeathCaster.mdl\", GetUnitX( GetSellingUnit() ), GetUnitY( GetSellingUnit() ) ))\r\n    call RemoveUnit(GetSellingUnit())\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_OneTime_seller takes nothing returns nothing\r\n    set gg_trg_OneTime_seller = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_OneTime_seller, EVENT_PLAYER_UNIT_SELL_ITEM )\r\n    call TriggerAddCondition( gg_trg_OneTime_seller, Condition( function Trig_OneTime_seller_Conditions ) )\r\n    call TriggerAddAction( gg_trg_OneTime_seller, function Trig_OneTime_seller_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}