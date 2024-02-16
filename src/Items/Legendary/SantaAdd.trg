{
  "Id": 50332733,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function SantaLogic takes item t returns boolean\r\n    local integer cyclA = 1\r\n    local boolean l = false\r\n    \r\n    loop\r\n        exitwhen cyclA > 12\r\n        if t == udg_SantaItem[cyclA] then\r\n            set l = true\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    set t = null\r\n    return l\r\nendfunction\r\n\r\nfunction Trig_SantaAdd_Conditions takes nothing returns boolean\r\n    return SantaLogic(GetManipulatedItem())\r\nendfunction\r\n\r\nfunction Trig_SantaAdd_Actions takes nothing returns nothing\r\n    local integer cyclB = 1\r\n    local integer i = GetPlayerId( GetOwningPlayer( GetManipulatingUnit() ) )\r\n    local integer j\r\n\r\n\t    loop\r\n\t\texitwhen cyclB > 3\r\n\t\tset j = (3*i) + cyclB \r\n\t\tif udg_SantaItem[j] == GetManipulatedItem() then\r\n\t\t\tset udg_SantaItem[j] = null\r\n\t\tendif\r\n\t\tset cyclB = cyclB + 1\r\n\t    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SantaAdd takes nothing returns nothing\r\n    set gg_trg_SantaAdd = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_SantaAdd, EVENT_PLAYER_UNIT_PICKUP_ITEM )\r\n    call TriggerAddCondition( gg_trg_SantaAdd, Condition( function Trig_SantaAdd_Conditions ) )\r\n    call TriggerAddAction( gg_trg_SantaAdd, function Trig_SantaAdd_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}