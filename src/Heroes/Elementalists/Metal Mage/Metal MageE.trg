{
  "Id": 50333267,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Metal_MageE_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel(GetOrderedUnit(), 'A0NG') > 0\r\nendfunction\r\n\r\nfunction Metal_MageECast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( \"mtme\" ) )\r\n    local real per = LoadReal( udg_hash, id, StringHash( \"mtme\" ) )\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    \r\n        call GroupEnumUnitsInRange( g, GetUnitX( caster ), GetUnitY( caster ), 900, null )\r\n        loop\r\n            set u = FirstOfGroup(g)\r\n            exitwhen u == null\r\n            if unitst( u, caster, \"ally\" ) and u != caster then\r\n                call healst( caster, u, RMaxBJ( 1,GetUnitState( u, UNIT_STATE_MAX_LIFE) * per) )\r\n\t\tcall manast( caster, u, RMaxBJ( 1,GetUnitState( u, UNIT_STATE_MAX_MANA) * per) )\r\n            endif\r\n            call GroupRemoveUnit(g,u)\r\n            set u = FirstOfGroup(g)\r\n        endloop\r\n    \r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set caster = null\r\nendfunction\r\n\r\nfunction Trig_Metal_MageE_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( GetOrderedUnit() )\r\n    local integer lvl\r\n    \r\n    set lvl = GetUnitAbilityLevel( GetOrderedUnit(), 'A0NG' )\r\n\r\n    if GetIssuedOrderId() == OrderId(\"immolation\") then\r\n        call UnitAddAbility( GetOrderedUnit(), 'A0LT')\r\n        \r\n        if LoadTimerHandle( udg_hash, id, StringHash( \"mtme\" ) ) == null then\r\n            call SaveTimerHandle( udg_hash, id, StringHash( \"mtme\" ), CreateTimer() )\r\n        endif\r\n        set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"mtme\" ) ) ) \r\n        call SaveUnitHandle( udg_hash, id, StringHash( \"mtme\" ), GetOrderedUnit() )   \r\n        call SaveReal( udg_hash, id, StringHash( \"mtme\" ), lvl * 0.004 )\r\n        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( GetOrderedUnit() ), StringHash( \"mtme\" ) ), 1, true, function Metal_MageECast )\r\n    elseif GetIssuedOrderId() == OrderId(\"unimmolation\") then\r\n        call UnitRemoveAbility( GetOrderedUnit(), 'A0LT')\r\n        call UnitRemoveAbility( GetOrderedUnit(), 'B06J')\r\n        call FlushChildHashtable( udg_hash, GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"mtme\" ) ) ) )\r\n        call DestroyTimer( LoadTimerHandle( udg_hash, id, StringHash( \"mtme\" ) ) )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Metal_MageE takes nothing returns nothing\r\n    set gg_trg_Metal_MageE = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Metal_MageE, EVENT_PLAYER_UNIT_ISSUED_ORDER )\r\n    call TriggerAddCondition( gg_trg_Metal_MageE, Condition( function Trig_Metal_MageE_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Metal_MageE, function Trig_Metal_MageE_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}