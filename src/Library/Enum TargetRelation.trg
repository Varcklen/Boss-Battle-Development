{
  "Id": 50332053,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library TargetRelation\r\n    \r\n    globals\r\n        \r\n        \r\n        constant integer TARGET_ALLY_NUM = 0\r\n        constant integer TARGET_ENEMY_NUM = 1\r\n        constant integer TARGET_ALL_NUM = 2\r\n        \r\n        private constant integer ENUM_MAX = 2\r\n    endglobals\r\n\r\n    struct TargetRelation\r\n        readonly integer enum\r\n    \r\n        method isEnumCorrect takes nothing returns boolean\r\n            return enum >= 0 or enum <= ENUM_MAX\r\n        endmethod\r\n    \r\n        static method create takes integer enum returns TargetRelation\r\n            // Если мы переопределяем метод create\r\n            // мы сами должны вызвать метод allocate\r\n            local TargetRelation p = TargetRelation.allocate()\r\n            set p.enum = enum\r\n            \r\n            // Возвращаем созданный экземпляр\r\n            if p.enum < 0 then\r\n                set p.enum = 0\r\n                call BJDebugMsg(\"Warning! The specified enum was less than 0. It is now 0.\")\r\n            elseif p.enum > ENUM_MAX then\r\n                set p.enum = ENUM_MAX\r\n                call BJDebugMsg(\"Warning! The specified enum was more than \" + I2S(ENUM_MAX) + \". It is now \"+ I2S(ENUM_MAX) +\".\")\r\n            endif\r\n            return p\r\n        endmethod\r\n    \r\n        static method TARGET_ALLY takes nothing returns integer\r\n            return TARGET_ALLY_NUM\r\n        endmethod\r\n        \r\n        static method TARGET_ENEMY takes nothing returns integer\r\n            return TARGET_ENEMY_NUM\r\n        endmethod\r\n        \r\n        static method TARGET_ALL takes nothing returns integer\r\n            return TARGET_ALL_NUM\r\n        endmethod\r\n    endstruct\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}