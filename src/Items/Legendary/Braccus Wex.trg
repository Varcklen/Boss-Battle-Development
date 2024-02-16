{
  "Id": 50332753,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope BraccusWex initializer Triggs\r\n    globals\r\n        private constant integer BRACCUS_WEX_SPELL_POWER_BONUS = 50\r\n    endglobals\r\n\r\n    private function Conditions takes nothing returns boolean\r\n        return GetItemTypeId(GetManipulatedItem()) == 'I071'\r\n    endfunction\r\n\r\n    private function PickUp takes nothing returns nothing\r\n        call spdst( GetManipulatingUnit(), BRACCUS_WEX_SPELL_POWER_BONUS )\r\n    endfunction\r\n    \r\n    private function Drop takes nothing returns nothing\r\n        call spdst( GetManipulatingUnit(), -BRACCUS_WEX_SPELL_POWER_BONUS )\r\n    endfunction\r\n\r\n    private function Triggs takes nothing returns nothing\r\n        local trigger trig = CreateTrigger()\r\n        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_PICKUP_ITEM ) \r\n        call TriggerAddCondition( trig, Condition( function Conditions ) )\r\n        call TriggerAddAction( trig, function PickUp)\r\n        \r\n        set trig = CreateTrigger()\r\n        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DROP_ITEM )\r\n        call TriggerAddCondition( trig, Condition( function Conditions ) )\r\n        call TriggerAddAction( trig, function Drop)\r\n        \r\n        set trig = null\r\n    endfunction\r\nendscope\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}