{
  "Id": 50332189,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope MMDAspects initializer init\r\n\r\n    globals\r\n        private integer array LastChoosedAspect[PLAYERS_LIMIT_ARRAYS]\r\n    endglobals\r\n\r\n    private function FightStartGlobal takes nothing returns nothing\r\n        local integer i\r\n        \r\n        set i = 1\r\n        loop\r\n            exitwhen i > PLAYERS_LIMIT\r\n            if LastChoosedAspect[i] != ChoosedAspect[i] and GetPlayerSlotState( Player( i - 1 ) ) == PLAYER_SLOT_STATE_PLAYING then\r\n                set LastChoosedAspect[i] = ChoosedAspect[i]\r\n                if ChoosedAspect[i] != 0 then\r\n                    call MMD_LogEvent2(\"aspect_\" + I2S(i),GetUnitName(udg_hero[i]),BlzGetAbilityTooltip(ChoosedAspect[i], 0) )\r\n                else\r\n                    call MMD_LogEvent2(\"aspect_\" + I2S(i),GetUnitName(udg_hero[i]),\"none\" )\r\n                endif\r\n            endif\r\n            set i = i + 1\r\n        endloop\r\n    endfunction\r\n    \r\n    private function init takes nothing returns nothing\r\n        local integer i\r\n        \r\n        call CreateEventTrigger( \"udg_FightStartGlobal_Real\", function FightStartGlobal, null )\r\n        \r\n        set i = 1\r\n        loop\r\n            exitwhen i > PLAYERS_LIMIT\r\n            set LastChoosedAspect[i] = 0\r\n            //call MMD_UpdateValueString(\"aspect_\"+ I2S(i),Player(i-1),\"none\")\r\n            //call MMD_DefineEvent2(\"aspect_\"+ I2S(i),\"{0} {1}\",\"Hero\",\"Aspect\")\r\n            set i = i + 1\r\n        endloop\r\n    endfunction\r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}