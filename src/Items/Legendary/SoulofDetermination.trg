{
  "Id": 50332747,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SoulofDetermination_Conditions takes nothing returns boolean \r\n\treturn GetItemTypeId(GetManipulatedItem()) == 'I0E4'\r\nendfunction \r\n\r\nfunction SoulofDetermination takes nothing returns nothing \r\n\tlocal integer id = GetHandleId( GetExpiredTimer( ) )\r\n    local unit c = LoadUnitHandle( udg_hash, id, StringHash( \"slod\" ) )\r\n    local item it = LoadItemHandle( udg_hash, id, StringHash( \"slodt\" ) )\r\n    local integer id1\r\n    local integer cyclA\r\n    local unit u\r\n    local boolean l = true\r\n    \r\n    if not(UnitHasItem(c,it )) then\r\n        call FlushChildHashtable( udg_hash, id )\r\n        call DestroyTimer( GetExpiredTimer() )\r\n    elseif udg_Heroes_Amount - udg_Heroes_Deaths == 1 and inv( c, 'I0E4') > 0 and GetUnitState( c, UNIT_STATE_LIFE) > 0.405 and udg_fightmod[0] and not(udg_fightmod[3]) then\r\n        set cyclA = 1\r\n        loop\r\n            exitwhen cyclA > 4\r\n            set u = udg_hero[cyclA]\r\n            if IsUnitInGroup(u, udg_DeadHero) and GetPlayerSlotState( Player( cyclA - 1 ) ) == PLAYER_SLOT_STATE_PLAYING and GetUnitAbilityLevel( u, 'A19D') == 0 then\r\n                call ResInBattle( c, u, 100 )\r\n            elseif GetUnitAbilityLevel( u, 'A19D') > 0 then\r\n                set l = false\r\n            endif\r\n            set cyclA = cyclA + 1\r\n        endloop\r\n        if l then\r\n            call stazisst( c, it )\r\n            call statst( c, 5, 5, 5, 0, true )\r\n        endif\r\n    endif\r\n    \r\n    set it = null\r\n    set c = null\r\nendfunction \r\n\r\nfunction Trig_SoulofDetermination_Actions takes nothing returns nothing \r\n\tlocal integer id = GetHandleId( GetManipulatedItem() )\r\n\t\r\n    if LoadTimerHandle( udg_hash, id, StringHash( \"slod\" ) ) == null  then\r\n        call SaveTimerHandle( udg_hash, id, StringHash( \"slod\" ), CreateTimer() )\r\n    endif \r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( \"slod\" ) ) ) \r\n\tcall SaveUnitHandle( udg_hash, id, StringHash( \"slod\" ), GetManipulatingUnit() ) \r\n    call SaveItemHandle( udg_hash, id, StringHash( \"slodt\" ), GetManipulatedItem() ) \r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( GetManipulatedItem() ), StringHash( \"slod\" ) ), 1, true, function SoulofDetermination ) \r\nendfunction \r\n\r\n//=========================================================================== \r\nfunction InitTrig_SoulofDetermination takes nothing returns nothing \r\n\tset gg_trg_SoulofDetermination = CreateTrigger( ) \r\n\tcall TriggerRegisterAnyUnitEventBJ( gg_trg_SoulofDetermination, EVENT_PLAYER_UNIT_PICKUP_ITEM ) \r\n\tcall TriggerAddCondition( gg_trg_SoulofDetermination, Condition( function Trig_SoulofDetermination_Conditions ) ) \r\n\tcall TriggerAddAction( gg_trg_SoulofDetermination, function Trig_SoulofDetermination_Actions ) \r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}