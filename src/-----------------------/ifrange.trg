{
  "Id": 50332049,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_ifrange_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetOwningPlayer(udg_hero[1])) + 1\r\n    local integer ab = udg_DB_Hero_FirstSpell[udg_HeroNum[i]]\r\n\r\n\r\n\tcall DisplayTimedTextToForce( GetPlayersAll(), 5.00, R2S(BlzGetAbilityRealLevelField(BlzGetUnitAbility(udg_hero[1], ab), ABILITY_RLF_CAST_RANGE, 0)) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_ifrange takes nothing returns nothing\r\n    set gg_trg_ifrange = CreateTrigger(  )\r\n    call TriggerRegisterPlayerChatEvent( gg_trg_ifrange, Player(0), \"1\", true )\r\n    call TriggerAddAction( gg_trg_ifrange, function Trig_ifrange_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}