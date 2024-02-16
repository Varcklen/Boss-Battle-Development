{
  "Id": 50332216,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function MagicLogic takes nothing returns boolean\r\n    /*local integer cyclA = 1\r\n    local integer cyclAEnd = udg_Database_InfoNumberHeroes\r\n    local boolean l = false\r\n    \r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        if GetSpellAbilityId() == Database_Hero_Abilities[1][cyclA] then\r\n            set l = true\r\n        endif\r\n        set cyclA = cyclA  + 1\r\n    endloop*/\r\n    return GetSpellAbilityId() == Database_Hero_Abilities[1][udg_HeroNum[GetUnitUserData(GetSpellAbilityUnit())]] \r\nendfunction\r\n\r\nfunction Trig_Magic_Actions takes nothing returns nothing\r\n    local integer rand\r\n    \r\n    if IsUnitInGroup(GetSpellAbilityUnit(), udg_heroinfo) and MagicLogic() and combat( GetSpellAbilityUnit(), false, 0 ) then\r\n        set udg_RandomLogic = true\r\n        set udg_Caster = GetSpellAbilityUnit()\r\n        set udg_Level = GetRandomInt( 1, 5 )\r\n        set rand = GetRandomInt( 1, 3 )\r\n        if rand == 1 then\r\n            call TriggerExecute( udg_DB_Trigger_One[GetRandomInt( 1, udg_Database_NumberItems[14])] )\r\n        elseif rand == 2 then\r\n            call TriggerExecute( udg_DB_Trigger_Two[GetRandomInt( 1, udg_Database_NumberItems[15])] )\r\n        else\r\n            call TriggerExecute( udg_DB_Trigger_Three[GetRandomInt( 1, udg_Database_NumberItems[16])] )\r\n        endif\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Magic takes nothing returns nothing\r\n    set gg_trg_Magic = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Magic )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Magic, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddAction( gg_trg_Magic, function Trig_Magic_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}