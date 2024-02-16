{
  "Id": 50332765,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SPIG_Conditions takes nothing returns boolean\r\n    return inv( GetDyingUnit(), 'I097' ) > 0 and combat( GetDyingUnit(), false, 0 ) and not( udg_fightmod[3] )\r\nendfunction\r\n\r\nfunction Trig_SPIG_Actions takes nothing returns nothing\r\n    local integer i = GetUnitUserData(GetDyingUnit())\r\n    local integer id = GetHandleId( GetDyingUnit() )\r\n    local integer s = LoadInteger( udg_hash, id, StringHash( udg_QuestItemCode[5] ) ) + 1\r\n    local item it = GetItemOfTypeFromUnitBJ(GetDyingUnit(), 'I097')\r\n    \r\n    call SaveInteger( udg_hash, id, StringHash( udg_QuestItemCode[5] ), s )\r\n\r\n    if s == udg_QuestNum[5] then\r\n        call BlzSetItemExtendedTooltip( it, words( GetDyingUnit(), BlzGetItemDescription(it), \"|cFF959697(\", \")|r\", \"Complete!\" ) ) // sadtwig\r\n        //call BlzSetItemIconPath( it, words( GetDyingUnit(), BlzGetItemDescription(it), \"|cFF959697(\", \")|r\", \"Complete!\" ) )\r\n    elseif s < udg_QuestNum[5] then\r\n        call QuestDiscription( GetDyingUnit(), 'I097', s, udg_QuestNum[5] )\r\n    endif\r\n    \r\n    set it = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SPIG takes nothing returns nothing\r\n    set gg_trg_SPIG = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_SPIG, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_SPIG, Condition( function Trig_SPIG_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SPIG, function Trig_SPIG_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}