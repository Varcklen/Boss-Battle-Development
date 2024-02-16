{
  "Id": 50332433,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope EnchantedThorium initializer Triggs\r\n    private function ItemAdd takes nothing returns nothing\r\n        if GetItemTypeId(GetManipulatedItem()) == 'I0EM' then\r\n            call SetRaritySpawn( udg_RarityChance[3]+4, udg_RarityChance[2]+4 )\r\n        endif\r\n    endfunction\r\n    \r\n    private function ItemRemove takes nothing returns nothing\r\n        if GetItemTypeId(GetManipulatedItem()) == 'I0EM' then\r\n            call SetRaritySpawn( udg_RarityChance[3]-4, udg_RarityChance[2]-4 )\r\n        endif\r\n    endfunction\r\n\r\n    private function Triggs takes nothing returns nothing\r\n        local trigger trig = CreateTrigger()\r\n        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_PICKUP_ITEM )\r\n        call TriggerAddAction( trig, function ItemAdd)\r\n        \r\n        set trig = CreateTrigger()\r\n        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DROP_ITEM )\r\n        call TriggerAddAction( trig, function ItemRemove)\r\n        set trig = null\r\n    endfunction\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}