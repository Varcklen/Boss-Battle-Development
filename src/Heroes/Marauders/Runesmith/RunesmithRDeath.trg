{
  "Id": 503330771,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope RunesmithRDeath initializer init\r\n\r\n    globals\r\n        private constant integer ID_ROCK = 'o020'\r\n        private constant string ID_HASH_CARVE = \"runesmith_carve\"\r\n        private constant string ID_HASH_CARVE_TARGET = \"runesmith_carve_target\"\r\n        private constant string ID_HASH_CARVE_ORIGIN_ABILITY = \"runesmith_carve_origin_ability\"\r\n    endglobals\r\n    \r\n    function Trig_RunesmithRDeath_Conditions takes nothing returns boolean\r\n        return GetUnitTypeId(GetDyingUnit()) == ID_ROCK\r\n    endfunction\r\n\r\n    function Trig_RunesmithRDeath_Actions takes nothing returns nothing\r\n        local unit target = GetDyingUnit()\r\n        local integer id = GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( target ), StringHash( ID_HASH_CARVE ) ) )\r\n        local integer ability_id = LoadInteger( udg_hash, id, StringHash( ID_HASH_CARVE_ORIGIN_ABILITY ) )\r\n        \r\n        if not( id == null ) and not( ability_id == null) then\r\n            call RunesmithRCarveAction(id, target, ability_id)\r\n        endif\r\n        \r\n        set target = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        set gg_trg_RunesmithRDeath = CreateTrigger( )\r\n        call TriggerRegisterAnyUnitEventBJ( gg_trg_RunesmithRDeath, EVENT_PLAYER_UNIT_DEATH )\r\n        call TriggerAddCondition( gg_trg_RunesmithRDeath, Condition( function Trig_RunesmithRDeath_Conditions ) )\r\n        call TriggerAddAction( gg_trg_RunesmithRDeath, function Trig_RunesmithRDeath_Actions )\r\n    endfunction\r\n    \r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}