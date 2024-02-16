{
  "Id": 50332812,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_GiveLvL_Conditions takes nothing returns boolean\r\n    return inv( udg_hero[GetPlayerId(GetOwningPlayer(GetLevelingUnit())) + 1], 'I0BW' ) > 0\r\nendfunction\r\n\r\nfunction Trig_GiveLvL_Actions takes nothing returns nothing\r\n    if GetHeroLevel(GetLevelingUnit()) >= udg_QuestNum[13] then\r\n        call SetWidgetLife( GetItemOfTypeFromUnitBJ(GetLevelingUnit(), 'I0BW'), 0 )\r\n        set bj_lastCreatedItem = CreateItem( 'I0C0', GetUnitX(GetLevelingUnit()), GetUnitY(GetLevelingUnit()))\r\n        call UnitAddItem(GetLevelingUnit(), bj_lastCreatedItem)\r\n        call textst( \"|c00ffffff Hunger for knowledge complete!\", GetLevelingUnit(), 64, GetRandomReal( 45, 135 ), 12, 1.5 )\r\n        call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\ReviveHuman\\\\ReviveHuman.mdl\", GetUnitX(GetLevelingUnit()), GetUnitY(GetLevelingUnit()) ) )\r\n        set udg_QuestDone[GetPlayerId( GetOwningPlayer(GetLevelingUnit()) ) + 1] = true\r\n    else\r\n        call QuestDiscription( GetLevelingUnit(), 'I0BW', GetHeroLevel(GetLevelingUnit()), udg_QuestNum[13] )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_GiveLvL takes nothing returns nothing\r\n    set gg_trg_GiveLvL = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_GiveLvL, EVENT_PLAYER_HERO_LEVEL )\r\n    call TriggerAddCondition( gg_trg_GiveLvL, Condition( function Trig_GiveLvL_Conditions ) )\r\n    call TriggerAddAction( gg_trg_GiveLvL, function Trig_GiveLvL_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}