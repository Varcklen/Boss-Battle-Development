{
  "Id": 50332859,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_RuneL_Conditions takes nothing returns boolean\r\n    if udg_logic[36] then\r\n        return false\r\n    endif\r\n    if not( RuneLogic(GetManipulatedItem()) ) then\r\n        return false\r\n    endif\r\n    return true\r\nendfunction\r\n\r\nfunction Trig_RuneL_Actions takes nothing returns nothing\r\n    local unit n = GetManipulatingUnit()\r\n    local integer i = CorrectPlayer(n)\r\n    local boolean l = LoadBoolean( udg_hash, GetHandleId( n ), StringHash( \"pkblt\" ) )\r\n    local boolean k = LoadBoolean( udg_hash, GetHandleId( n ), StringHash( \"pkbl\" ) )\r\n    local boolean b = false\r\n    \r\n    if l then\r\n        set udg_logic[i + 26] = false\r\n        set b = true\r\n        call iconoff( i, \"Руна\" )\r\n    else\r\n        set udg_Set_Rune_Number[i] = udg_Set_Rune_Number[i] - 1\r\n        if udg_logic[i + 26] and udg_Set_Rune_Number[i] < 3 then\r\n            if not( k ) then\r\n                set udg_logic[i + 26] = false\r\n                set b = true\r\n            endif\r\n            call DisplayTimedTextToPlayer( GetOwningPlayer(n), 0, 0, 5., \"Set |cff848484Rune|r is now disassembled!\")\r\n            call iconoff( i, \"Руна\" )\r\n        endif\r\n    endif\r\n    \r\n    if b then\r\n    \tcall RuneSetLose.SetDataUnit(\"caster\", n )\r\n    \tcall RuneSetLose.SetDataItem(\"item\", GetManipulatedItem() )\r\n    \tcall RuneSetLose.Invoke()\r\n        /*set udg_Event_RuneSetRemove_Hero = n\r\n        set udg_Event_RuneSetRemove_Item = GetManipulatedItem()\r\n        \r\n        set udg_Event_RuneSetRemove_Real = 0.00\r\n        set udg_Event_RuneSetRemove_Real = 1.00\r\n        set udg_Event_RuneSetRemove_Real = 0.00*/\r\n        \r\n        if inv(n, 'I00C') > 0 then\r\n            call UnitAddAbility( n, 'A0ZA')\r\n        endif\r\n        if inv(n, 'I02G') > 0 then\r\n            call UnitAddAbility( n, 'A0YZ')\r\n        endif\r\n        if inv(n, 'I00O') > 0 then\r\n            call UnitAddAbility( n, 'A0Z1')\r\n        endif\r\n        if inv(n, 'I00M') > 0 then\r\n            call UnitAddAbility( n, 'A0CB')\r\n        endif\r\n        if inv(n, 'I06N') > 0 then\r\n            call UnitAddAbility( n, 'A0OU')\r\n        endif\r\n        if inv(n, 'I078') > 0 then\r\n            call UnitAddAbility( n, 'A0L9')\r\n        endif\r\n        if inv(n, 'I0BL') > 0 then\r\n            call UnitAddAbility( n, 'A0M9')\r\n        endif\r\n    endif\r\n    \r\n    set n = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_RuneL takes nothing returns nothing\r\n    set gg_trg_RuneL = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_RuneL, EVENT_PLAYER_UNIT_DROP_ITEM )\r\n    call TriggerAddCondition( gg_trg_RuneL, Condition( function Trig_RuneL_Conditions ) )\r\n    call TriggerAddAction( gg_trg_RuneL, function Trig_RuneL_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}