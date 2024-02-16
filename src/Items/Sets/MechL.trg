{
  "Id": 50332854,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MechL_Conditions takes nothing returns boolean\r\n    if udg_logic[36] then\r\n        return false\r\n    endif\r\n    if not( Mech_Logic(GetManipulatedItem()) ) then\r\n        return false\r\n    endif\r\n    return true\r\nendfunction\r\n\r\nfunction Trig_MechL_Actions takes nothing returns nothing\r\n    local unit n = GetManipulatingUnit()\r\n    local integer i = GetUnitUserData(n)\r\n    local integer m = -1\r\n\r\n    if GetItemTypeId(GetManipulatedItem()) == 'I05I' or GetItemTypeId(GetManipulatedItem()) == 'I03I' then\r\n        set m = m - 2\r\n    endif\r\n    call SetCount_AddPiece( n, SET_MECH, m )\r\n\r\n    set n = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MechL takes nothing returns nothing\r\n    set gg_trg_MechL = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MechL, EVENT_PLAYER_UNIT_DROP_ITEM )\r\n    call TriggerAddCondition( gg_trg_MechL, Condition( function Trig_MechL_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MechL, function Trig_MechL_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}