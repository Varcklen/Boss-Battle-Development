{
  "Id": 50332366,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function TestRandomCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    local unit hero = LoadUnitHandle( udg_hash, id, StringHash(\"test\") )\r\n    local integer key1 = LoadInteger( udg_hash, id, StringHash(\"test1\") )\r\n    local integer key2 = LoadInteger( udg_hash, id, StringHash(\"test2\") )\r\n    local trigger trig = null\r\n    \r\n    set key1 = key1 + 1\r\n    if key1 > udg_Database_NumberItems[13+key2] then\r\n        set key1 = 1\r\n        set key2 = key2 + 1\r\n        if key2 >= 4 then\r\n            call FlushChildHashtable( udg_hash, id )\r\n            call DestroyTimer( GetExpiredTimer() )\r\n            return\r\n        endif\r\n    endif\r\n\r\n    if key2 == 1 then\r\n        set trig = udg_DB_Trigger_One[key1]\r\n    elseif key2 == 2 then\r\n        set trig = udg_DB_Trigger_Two[key1]\r\n    elseif key2 == 3 then\r\n        set trig = udg_DB_Trigger_Three[key1]\r\n    endif\r\n    set udg_combatlogic[1] = true\r\n    set udg_fightmod[0] = true\r\n    call BJDebugMsg(\"===================================\")\r\n    call BJDebugMsg(\"Ability: key1: \" + I2S(key1) + \" key2: \" + I2S(key2) )\r\n    call CastRandomAbility(hero, 5, trig )\r\n    call SaveInteger( udg_hash, id, StringHash(\"test1\"), key1 )\r\n    call SaveInteger( udg_hash, id, StringHash(\"test2\"), key2 )\r\n    \r\n    set trig = null\r\n    set hero = null\r\nendfunction\r\n\r\nfunction Trig_CastRandom_Actions takes nothing returns nothing\r\n    local integer id\r\n    if udg_hero[1] == null then\r\n        return\r\n    endif\r\n    set id = InvokeTimerWithUnit(udg_hero[1], \"test\", 0.5, true, function TestRandomCast )\r\n    call SaveInteger( udg_hash, id, StringHash(\"test2\"), 1 )\r\n    call BJDebugMsg(\"Start cast ALL abilities random.\")\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_CastRandom takes nothing returns nothing\r\n    set gg_trg_CastRandom = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_CastRandom )\r\n    call TriggerRegisterPlayerChatEvent( gg_trg_CastRandom, Player(0), \"-castrandom\", true )\r\n    call TriggerAddAction( gg_trg_CastRandom, function Trig_CastRandom_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}