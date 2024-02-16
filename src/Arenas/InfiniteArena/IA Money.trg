{
  "Id": 50333693,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_IA_Money_Conditions takes nothing returns boolean\r\n    return udg_fightmod[2] and GetUnitAbilityLevel( GetDyingUnit(), 'A0CZ' ) > 0 and GetOwningPlayer(GetDyingUnit()) == Player(10)\r\nendfunction\r\n\r\nfunction Trig_IA_Money_Actions takes nothing returns nothing\r\n    local integer i\r\n    local integer id = GetHandleId( GetDyingUnit() )\r\n    local integer money = LoadInteger( udg_hash, id, StringHash( \"goldIA\" ) )\r\n    \r\n    if money != 0 then\r\n        if udg_modgood[21] then\r\n            set money = R2I(money * 1.1)\r\n        endif\r\n        set i = 1\r\n        loop\r\n            exitwhen i > 4\r\n            if GetPlayerSlotState(Player(i - 1)) == PLAYER_SLOT_STATE_PLAYING then\r\n                call moneyst( udg_hero[i], money )\r\n            endif\r\n            set i = i + 1\r\n        endloop\r\n    endif\r\n    call RemoveSavedInteger(udg_hash, id, StringHash( \"goldIA\" ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_IA_Money takes nothing returns nothing\r\n    set gg_trg_IA_Money = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_IA_Money, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_IA_Money, Condition( function Trig_IA_Money_Conditions ) )\r\n    call TriggerAddAction( gg_trg_IA_Money, function Trig_IA_Money_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}