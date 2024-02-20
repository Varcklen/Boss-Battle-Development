{
  "Id": 50333398,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope TimerExpireStart initializer init\r\n\r\n\tprivate function action takes nothing returns nothing\r\n\t    local integer cyclA = 1\r\n\t    local integer cyclB\r\n\t\r\n\t    loop\r\n\t        exitwhen cyclA > 4\r\n\t        if GetPlayerSlotState(Player(cyclA - 1)) == PLAYER_SLOT_STATE_PLAYING and udg_item[3 * cyclA] != null then\r\n\t            set cyclB = 0\r\n\t            loop\r\n\t                exitwhen cyclB > 2\r\n\t                call DestroyEffect( AddSpecialEffect(\"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetItemX( udg_item[( 3 * cyclA ) - cyclB] ), GetItemY( udg_item[( 3 * cyclA ) - cyclB] ) ) )\r\n\t                call RemoveItem( udg_item[( 3 * cyclA ) - cyclB] )\r\n\t                set udg_item[( 3 * cyclA ) - cyclB] = null\r\n\t                set cyclB = cyclB + 1\r\n\t            endloop\r\n\t\t    if udg_worldmod[1] and udg_Boss_LvL == 2 then\r\n\t\t\tcall BlzFrameSetVisible(fastvis, false)\r\n\t\t\tcall BlzFrameSetVisible(fastbut, false)\r\n\t\t    endif\r\n\t        endif\r\n\t        set cyclA = cyclA + 1\r\n\t    endloop\r\n\t\r\n\t    set udg_Player_Readiness = udg_Heroes_Amount\r\n\t    call TriggerExecute( gg_trg_StartFight )\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t\tlocal trigger trig = CreateTrigger(  )\r\n\t    call TriggerRegisterTimerExpireEvent( trig, OutOfCombatTimer_Timer )\r\n\t    call TriggerAddAction( trig, function action )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}