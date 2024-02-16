{
  "Id": 50332740,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_EmperorKills_Conditions takes nothing returns boolean\r\n    return inv(Event_Hero_Kill_Unit, 'I07Z') > 0\r\nendfunction\r\n\r\nfunction Trig_EmperorKills_Actions takes nothing returns nothing\r\n    local integer kills = LoadInteger( udg_hash, GetHandleId( Event_Hero_Kill_Unit ), StringHash( \"kill\" ) )\r\n    \r\n    if kills == 50 then\r\n        call ChangeToolItem( Event_Hero_Kill_Unit, 'I07Z', \"|cFF959697(\", \")|r\", \"Active!\" )\r\n        call textst( \"|c00ffffff Emperor upgraded!\", Event_Hero_Kill_Unit, 64, GetRandomReal( 45, 135 ), 8, 1.5 )\r\n    elseif kills < 50 then\r\n        call ChangeToolItem( Event_Hero_Kill_Unit, 'I07Z', \"|cFF959697(\", \")|r\", I2S( kills ) + \"/50\" )\r\n        call textst( \"|c00ffffff \" + I2S( kills ) + \"/50\", Event_Hero_Kill_Unit, 64, GetRandomReal( 45, 135 ), 8, 1.5 )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_EmperorKills takes nothing returns nothing\r\n    set gg_trg_EmperorKills = CreateTrigger(  )\r\n     call TriggerRegisterVariableEvent( gg_trg_EmperorKills, \"Event_Hero_Kill_Real\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_EmperorKills, Condition( function Trig_EmperorKills_Conditions ) )\r\n    call TriggerAddAction( gg_trg_EmperorKills, function Trig_EmperorKills_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}