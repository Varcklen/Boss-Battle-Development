{
  "Id": 50332222,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope ChaosEarring initializer Triggs\r\n    globals \r\n        private integer count = 0\r\n    endglobals \r\n\r\n    private function ChaosEarring_Conditions takes nothing returns boolean\r\n        return udg_modgood[16] and not( udg_fightmod[3] )\r\n    endfunction\r\n\r\n    private function UniqueChange takes integer k returns nothing\r\n        local integer i = 1\r\n        loop\r\n            exitwhen i > 4\r\n            if udg_hero[i] != null then\r\n                call skillst( i, k )\r\n            endif\r\n            set i = i + 1\r\n        endloop\r\n    endfunction\r\n\r\n    private function ChaosEarring_Actions takes nothing returns nothing\r\n        set count = count + 1\r\n        if count >= 3 then\r\n            call UniqueChange(1)\r\n        endif\r\n    endfunction\r\n\r\n    private function ChaosEarringEnd_Conditions takes nothing returns boolean\r\n        return udg_modgood[16] and count >= 3\r\n    endfunction\r\n\r\n    private function ChaosEarringEnd_Actions takes nothing returns nothing\r\n        call UniqueChange(-1)\r\n        set count = 0\r\n    endfunction\r\n\r\n    private function Triggs takes nothing returns nothing\r\n        local trigger trig = CreateTrigger()\r\n        call TriggerRegisterVariableEvent( trig, \"udg_FightStartGlobal_Real\", EQUAL, 1.00 )\r\n        call TriggerAddCondition( trig, Condition( function ChaosEarring_Conditions ) )\r\n        call TriggerAddAction( trig, function ChaosEarring_Actions )\r\n        \r\n        set trig = CreateTrigger()\r\n        call TriggerRegisterVariableEvent( trig, \"udg_FightEndGlobal_Real\", EQUAL, 1.00 )\r\n        call TriggerAddCondition( trig, Condition( function ChaosEarringEnd_Conditions ) )\r\n        call TriggerAddAction( trig, function ChaosEarringEnd_Actions )\r\n        \r\n        set trig = null\r\n    endfunction\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}