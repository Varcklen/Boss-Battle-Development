{
  "Id": 50332845,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library BookOfOblivion\r\n\r\n    globals\r\n        integer array Book_Of_Oblivion_Cost[PLAYERS_LIMIT_ARRAYS]\r\n        constant integer BOOK_OF_OBLIVION_BASE_COST = 150\r\n    endglobals\r\n    \r\n    function Book_Of_Oblivion takes nothing returns nothing\r\n        local player p = GetTriggerPlayer()\r\n        local integer index = GetPlayerId(GetTriggerPlayer()) + 1\r\n        local integer cost = Book_Of_Oblivion_Cost[index]\r\n        local unit hero = udg_hero[index]\r\n        \r\n        if GetLocalPlayer() == p then\r\n            call BlzFrameSetVisible( BlzGetTriggerFrame(),false)\r\n            call BlzFrameSetVisible( BlzGetTriggerFrame(),true)\r\n        endif\r\n        \r\n        if hero == null then\r\n            return\r\n        endif\r\n        \r\n        if GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) >= cost then\r\n            call UnitAddItem( hero, CreateItem( 'I03S', GetUnitX(hero), GetUnitY(hero) ) )\r\n            call SetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD, IMaxBJ(0,GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) - cost))\r\n        endif\r\n        \r\n        set p = null\r\n        set hero = null\r\n    endfunction\r\n\r\n    public function Change_Cost takes player whichPlayer, integer newCost returns nothing\r\n        local integer index = GetPlayerId(whichPlayer) + 1\r\n        set Book_Of_Oblivion_Cost[index] = newCost\r\n        \r\n        if GetLocalPlayer() == whichPlayer then\r\n            call BlzFrameSetText( bookOfOblivionCostText, I2S(newCost) + \" G\" )\r\n        endif\r\n    endfunction\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}