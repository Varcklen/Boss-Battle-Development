{
  "Id": 50332761,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SLCG_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetSellingUnit()) == 'h007' and inv( GetBuyingUnit(), 'I0B9' ) > 0\r\nendfunction\r\n\r\nfunction Trig_SLCG_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetOwningPlayer(GetBuyingUnit())) + 1\r\n    local integer id = GetHandleId( GetBuyingUnit() )\r\n    local integer s = LoadInteger( udg_hash, id, StringHash( udg_QuestItemCode[16] ) ) + 1\r\n    \r\n    call SaveInteger( udg_hash, id, StringHash( udg_QuestItemCode[16] ), s )\r\n\r\n    if s >= udg_QuestNum[16] then\r\n        call RemoveItem( GetItemOfTypeFromUnitBJ(GetBuyingUnit(), 'I0B9') )\r\n        call UnitAddItem(GetBuyingUnit(), CreateItem( 'I0EZ', GetUnitX(GetBuyingUnit()), GetUnitY(GetBuyingUnit())))\r\n        call textst( \"|c00ffffff Scholar's Gambit done!\", GetBuyingUnit(), 64, GetRandomReal( 45, 135 ), 12, 1.5 )\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\ReviveHuman\\\\ReviveHuman.mdl\", GetUnitX(GetBuyingUnit()), GetUnitY(GetBuyingUnit()) ) )\r\n        set udg_QuestDone[i] = true\r\n    else\r\n        call QuestDiscription( GetBuyingUnit(), 'I0B9', s, udg_QuestNum[16] )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SLCG takes nothing returns nothing\r\n    set gg_trg_SLCG = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_SLCG, EVENT_PLAYER_UNIT_SELL_ITEM )\r\n    call TriggerAddCondition( gg_trg_SLCG, Condition( function Trig_SLCG_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SLCG, function Trig_SLCG_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}