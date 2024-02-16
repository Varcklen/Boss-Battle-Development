{
  "Id": 50332594,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope DittoTransform initializer init\r\n    private function FightEnd_Conditions takes nothing returns boolean\r\n        return udg_fightmod[3] == false\r\n    endfunction\r\n\r\n    private function FightEnd takes nothing returns nothing\r\n        local unit caster = udg_FightEnd_Unit\r\n        local item it\r\n        local integer i\r\n        \r\n        set i = 0\r\n        loop\r\n            exitwhen i > 5\r\n            set it = UnitItemInSlot(caster, i)\r\n            if SubString(BlzGetItemExtendedTooltip(it), 0, 15) == \"|cFFB20080Ditto\" then\r\n                call Inventory_ReplaceItemByNew(caster, it, 'I05H' )\r\n            endif\r\n            set i = i + 1\r\n        endloop\r\n        \r\n        set it = null\r\n        set caster = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger( \"udg_FightEnd_Real\", function FightEnd, function FightEnd_Conditions )\r\n    endfunction\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}