{
  "Id": 50333461,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope FedorEnd initializer init\r\n\r\n    globals\r\n        private constant integer ID_TRAIN = 'h00C'\r\n    endglobals\r\n\r\n    function FightEndGlobal takes nothing returns nothing\r\n        local group g = CreateGroup()\r\n        local unit u\r\n        \r\n        call GroupEnumUnitsInRect( g, udg_Boss_Rect, null )\r\n        loop\r\n            set u = FirstOfGroup(g)\r\n            exitwhen u == null\r\n            if GetUnitTypeId( u ) == ID_TRAIN then\r\n                call KillUnit( u )\r\n            endif\r\n            call GroupRemoveUnit(g,u)\r\n        endloop\r\n        \r\n        call GroupClear( g )\r\n        call DestroyGroup( g )\r\n        set u = null\r\n        set g = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger( \"udg_FightEndGlobal_Real\", function FightEndGlobal, null )\r\n    endfunction\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}