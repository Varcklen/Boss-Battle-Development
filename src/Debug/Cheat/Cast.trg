{
  "Id": 50332367,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cast_Conditions takes nothing returns boolean\r\n    return SubString(GetEventPlayerChatString(), 0, 5) == \"-cast\" \r\nendfunction\r\n\r\nfunction Trig_Cast_Actions takes nothing returns nothing\r\n    local string ket1S = SubString(GetEventPlayerChatString(), 6, 7)\r\n    local string ket2S = SubString(GetEventPlayerChatString(), 8, 10)\r\n    local integer key1 = S2I(ket1S)\r\n    local integer key2 = S2I(ket2S)\r\n    local trigger trig = null\r\n    \r\n    call BJDebugMsg(\"Random Ability used [\" + ket1S + \"][\" + ket2S + \"].\")\r\n    if udg_hero[1] == null then\r\n        call BJDebugMsg(\"ERROR! udg_hero[1] is null!\")\r\n        return\r\n    endif\r\n    if key1 == 1 then\r\n        set trig = udg_DB_Trigger_One[key2]\r\n    elseif key1 == 2 then\r\n        set trig = udg_DB_Trigger_Two[key2]\r\n    elseif key1 == 3 then\r\n        set trig = udg_DB_Trigger_Three[key2]\r\n    endif\r\n    set udg_combatlogic[1] = true\r\n    set udg_fightmod[0] = true\r\n    call CastLib_CastRandomAbility(udg_hero[1], trig, 5 )\r\n    \r\n    set trig = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cast takes nothing returns nothing\r\n    set gg_trg_Cast = CreateTrigger()\r\n    call TriggerRegisterPlayerChatEvent( gg_trg_Cast, Player(0), \"-cast\", false )\r\n    call TriggerAddCondition( gg_trg_Cast, Condition( function Trig_Cast_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Cast, function Trig_Cast_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}