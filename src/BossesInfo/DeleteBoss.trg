{
  "Id": 50333403,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library DeleteBoss \r\n\r\n\tprivate function BossClear takes unit boss returns nothing\r\n\t\tlocal integer bossLevel = BossSpawn_GetBossKeyLevel(boss)\r\n\t\tlocal integer bossIndex = BossSpawn_GetBossKeyIndex(boss)\r\n\t    local integer bossTriggerIndex\r\n\t\tlocal integer bossTriggerIndexInit\r\n\t\tlocal integer i\r\n\t\tlocal trigger triggerCheck\r\n\t\t\r\n\t\t//call BJDebugMsg(\"bossLevel: \" + I2S(bossLevel))\r\n\t\t\r\n\t\tif bossLevel == 0 then\r\n\t\t\treturn\r\n\t\tendif\r\n\t\t\r\n\t\tset bossTriggerIndexInit = ( bossIndex - 1 ) * 10\r\n\t\tset i = 1\r\n\t\t\r\n\t\t/*call BJDebugMsg(\"bossIndex: \" + I2S(bossIndex))\r\n\t\tcall BJDebugMsg(\"bossTriggerIndexInit: \" + I2S(bossTriggerIndexInit))\r\n\t\tcall BJDebugMsg(\"==========================\")*/\r\n\t\tloop\r\n\t        set bossTriggerIndex = bossTriggerIndexInit + i\r\n\t        //call BJDebugMsg(\"bossTriggerIndex: \" + I2S(bossTriggerIndex))\r\n\t        set triggerCheck = DB_Trigger_Boss[bossLevel][bossTriggerIndex]\r\n\t        if triggerCheck == null then\r\n\t        \t//call BJDebugMsg(\"null\")\r\n\t        \texitwhen true\r\n\t        endif\r\n\t        //call BJDebugMsg(\"Disabled!\")\r\n\t        call DisableTrigger( triggerCheck )\r\n\t        set i = i + 1\r\n\t    endloop\r\n\tendfunction\r\n\t\r\n\tprivate function onRemovalBoss takes unit u returns nothing\r\n\t    if IsUnitType(u, UNIT_TYPE_ANCIENT) and GetUnitUserData(u) == 5 then\r\n\t        call BossClear(u)\r\n\t    endif\r\n\tendfunction\r\n\t\r\n\thook RemoveUnit onRemovalBoss\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}