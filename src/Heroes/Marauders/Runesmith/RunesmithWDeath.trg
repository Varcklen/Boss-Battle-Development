{
  "Id": 503330761,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope RunesmithWDeath initializer init\r\n\r\n    globals\r\n         private constant integer ID_DECOY = 'h017'\r\n         private constant string ID_HASH_DECOY = \"runesmith_decoy\"\r\n    endglobals\r\n    \r\n    function Trig_RunesmithWDeath_Conditions takes nothing returns boolean\r\n        return GetUnitTypeId(GetDyingUnit()) == ID_DECOY\r\n    endfunction\r\n\r\n    function Trig_RunesmithWDeath_Actions takes nothing returns nothing\r\n        call RunesmithW_Cancel(LoadUnitHandle(udg_hash, GetHandleId( GetDyingUnit() ), StringHash( ID_HASH_DECOY )))\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        set gg_trg_RunesmithWDeath = CreateTrigger( )\r\n        call TriggerRegisterAnyUnitEventBJ( gg_trg_RunesmithWDeath, EVENT_PLAYER_UNIT_DEATH )\r\n        call TriggerAddCondition( gg_trg_RunesmithWDeath, Condition( function Trig_RunesmithWDeath_Conditions ) )\r\n        call TriggerAddAction( gg_trg_RunesmithWDeath, function Trig_RunesmithWDeath_Actions )\r\n    endfunction\r\n    \r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}