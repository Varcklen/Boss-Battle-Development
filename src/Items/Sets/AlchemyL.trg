{
  "Id": 50332867,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_AlchemyL_Conditions takes nothing returns boolean\r\n    if udg_logic[36] then\r\n        return false\r\n    endif\r\n    if not( AlchemyLogic(GetManipulatedItem()) ) then\r\n        return false\r\n    endif\r\n    return true\r\nendfunction\r\n\r\nfunction Trig_AlchemyL_Actions takes nothing returns nothing\r\n    local unit n = GetManipulatingUnit()//udg_hero[GetPlayerId(GetOwningPlayer(GetManipulatingUnit())) + 1]\r\n    local integer i = CorrectPlayer(n)//GetPlayerId(GetOwningPlayer(n)) + 1\r\n    local integer cyclA = 0\r\n    local boolean l = LoadBoolean( udg_hash, GetHandleId( n ), StringHash( \"pkblt\" ) )\r\n    local boolean k = LoadBoolean( udg_hash, GetHandleId( n ), StringHash( \"pkbl\" ) )\r\n    \r\n    if l then\r\n        set udg_logic[i + 10] = false\r\n        call iconoff( i, \"Алхимия\" )\r\n    else\r\n        set udg_Set_Alchemy_Number[i] = udg_Set_Alchemy_Number[i] - 1\r\n        if udg_logic[i + 10] and udg_Set_Alchemy_Number[i] < 3 then\r\n            if not( k ) then\r\n                set udg_logic[i + 10] = false\r\n                call UnitRemoveAbility( n, 'A04F' )\r\n                call UnitRemoveAbility( n, 'B08X' )\r\n            endif\r\n            call DisplayTimedTextToPlayer(GetOwningPlayer(n), 0, 0, 5., \"Set |cfffe9a2eAlchemy|r is now disassembled!\")\r\n            call iconoff( i, \"Алхимия\" )\r\n        endif\r\n    endif\r\n    \r\n    //call AllSetRing( n, 6, GetManipulatedItem() )\r\n    \r\n    set n = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_AlchemyL takes nothing returns nothing\r\n    set gg_trg_AlchemyL = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_AlchemyL, EVENT_PLAYER_UNIT_DROP_ITEM )\r\n    call TriggerAddCondition( gg_trg_AlchemyL, Condition( function Trig_AlchemyL_Conditions ) )\r\n    call TriggerAddAction( gg_trg_AlchemyL, function Trig_AlchemyL_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}