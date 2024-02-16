{
  "Id": 50332839,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function CorruptLogic takes item t returns boolean\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd = udg_Database_NumberItems[29]\r\n    local boolean l = false\r\n    \r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        if GetItemTypeId(t) == udg_DB_Item_Destroyed[cyclA] then\r\n            set l = true\r\n            set cyclA = cyclAEnd\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n\r\n    set t = null\r\n    return l\r\nendfunction\r\n\r\nfunction Trig_Corrupted_Conditions takes nothing returns boolean\r\n    if udg_logic[GetPlayerId(GetOwningPlayer(GetManipulatingUnit())) + 1 + 90] then\r\n        return false\r\n    endif\r\n    if not( CorruptLogic(GetManipulatedItem()) ) then\r\n        return false\r\n    endif\r\n    return true\r\nendfunction\r\n\r\nfunction Trig_Corrupted_Actions takes nothing returns nothing\r\n    set udg_logic[GetPlayerId(GetOwningPlayer(GetManipulatingUnit())) + 1 + 90] = true\r\n    call DisplayTimedTextToPlayer( GetOwningPlayer(GetManipulatingUnit()), 0, 0, 20, \"|cffcc0000Corrupted|r - the item is disposable and destroyed after use.\")\r\n    if GetLocalPlayer() == GetOwningPlayer(GetManipulatingUnit()) then\r\n        call StartSound(gg_snd_QuestLog)\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Corrupted takes nothing returns nothing\r\n    set gg_trg_Corrupted = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Corrupted, EVENT_PLAYER_UNIT_PICKUP_ITEM )\r\n    call TriggerAddCondition( gg_trg_Corrupted, Condition( function Trig_Corrupted_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Corrupted, function Trig_Corrupted_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}