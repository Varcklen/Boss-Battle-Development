{
  "Id": 50332370,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_List_Test_Actions takes nothing returns nothing\r\n    local ListInt list = ListInt.create()\r\n    local ArrayInt myArray = ArrayInt.create()\r\n    local integer i = 0\r\n    local integer rand\r\n    \r\n    /*call BJDebugMsg(\"====================\")\r\n    call BJDebugMsg(\"Add\")\r\n    call BJDebugMsg(\"====================\")\r\n    loop\r\n        exitwhen i > 9\r\n        set rand = GetRandomInt(1,100)\r\n        call list.Add(rand)\r\n        call BJDebugMsg(\"rand: \" + I2S(rand))\r\n        set i = i + 1\r\n    endloop*/\r\n    \r\n    call BJDebugMsg(\"====================\")\r\n    call BJDebugMsg(\"AddArray\")\r\n    call BJDebugMsg(\"====================\")\r\n    loop\r\n        exitwhen i > 9\r\n        set rand = GetRandomInt(1,100)\r\n        set myArray[i] = rand\r\n        call BJDebugMsg(\"rand: \" + I2S(rand))\r\n        set i = i + 1\r\n    endloop\r\n    call list.AddArray(myArray, 9)\r\n    \r\n    call BJDebugMsg(\"====================\")\r\n    call BJDebugMsg(\"RemoveByIndex\")\r\n    call BJDebugMsg(\"====================\")\r\n    //call list.RemoveByIndex(4)\r\n    set i = 0\r\n    loop\r\n        exitwhen i > 8\r\n        call BJDebugMsg(\"Number: \" + I2S(list.GetIntegerByIndex(i)))\r\n        set i = i + 1\r\n    endloop\r\n    \r\n\r\n    call list.destroy()\r\n    call myArray.destroy()\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_List_Test takes nothing returns nothing\r\n    set gg_trg_List_Test = CreateTrigger(  )\r\n    call TriggerRegisterPlayerChatEvent( gg_trg_List_Test, Player(0), \"1\", true )\r\n    call TriggerAddAction( gg_trg_List_Test, function Trig_List_Test_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}