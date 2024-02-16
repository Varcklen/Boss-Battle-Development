{
  "Id": 50332252,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_BuyItem_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetSoldUnit()) == 'n029'\r\nendfunction\r\n\r\nfunction Trig_BuyItem_Actions takes nothing returns nothing\r\n    call RemoveUnit( GetSoldUnit() )\r\n    if UnitInventoryCount(GetBuyingUnit()) >= 6 then\r\n        call DisplayTimedTextToForce( GetForceOfPlayer(GetOwningPlayer(GetBuyingUnit())), 5, \"The inventory is full.\" )\r\n        call SetPlayerState(GetOwningPlayer(GetBuyingUnit()), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(GetBuyingUnit()), PLAYER_STATE_RESOURCE_GOLD) + 350 )\r\n    else\r\n        call DestroyEffect ( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetBuyingUnit(), \"origin\") )\r\n        call ItemRandomizerAll( GetBuyingUnit(), 0 )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_BuyItem takes nothing returns nothing\r\n    set gg_trg_BuyItem = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_BuyItem, EVENT_PLAYER_UNIT_SELL )\r\n    call TriggerAddCondition( gg_trg_BuyItem, Condition( function Trig_BuyItem_Conditions ) )\r\n    call TriggerAddAction( gg_trg_BuyItem, function Trig_BuyItem_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}