{
  "Id": 50333398,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_EndTimerBoss_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclB\r\n\r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetPlayerSlotState(Player(cyclA - 1)) == PLAYER_SLOT_STATE_PLAYING and udg_item[3 * cyclA] != null then\r\n            set cyclB = 0\r\n            loop\r\n                exitwhen cyclB > 2\r\n                call DestroyEffect( AddSpecialEffect(\"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetItemX( udg_item[( 3 * cyclA ) - cyclB] ), GetItemY( udg_item[( 3 * cyclA ) - cyclB] ) ) )\r\n                call RemoveItem( udg_item[( 3 * cyclA ) - cyclB] )\r\n                set udg_item[( 3 * cyclA ) - cyclB] = null\r\n                set cyclB = cyclB + 1\r\n            endloop\r\n\t    if udg_worldmod[1] and udg_Boss_LvL == 2 then\r\n\t\tcall BlzFrameSetVisible(fastvis, false)\r\n\t\tcall BlzFrameSetVisible(fastbut, false)\r\n\t    endif\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n\r\n    set udg_Player_Readiness = udg_Heroes_Amount\r\n    call TriggerExecute( gg_trg_StartFight )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_EndTimerBoss takes nothing returns nothing\r\n    set gg_trg_EndTimerBoss = CreateTrigger(  )\r\n    call TriggerRegisterTimerExpireEvent( gg_trg_EndTimerBoss, udg_timer[1] )\r\n    call TriggerAddAction( gg_trg_EndTimerBoss, function Trig_EndTimerBoss_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}