{
  "Id": 50332414,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Death_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0DD' and udg_fightmod[1] and Battle_Ended == false\r\nendfunction\r\n\r\nfunction Trig_Death_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    call DisplayTextToForce( bj_FORCE_ALL_PLAYERS, \"Used |cffffcc00Tarot Card: Death|r.\" )\r\n    set udg_Heroes_Chanse = udg_Heroes_Chanse + 1\r\n    call MultiSetValue( udg_multi, 2, 1, I2S( udg_Heroes_Chanse ) )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 then\r\n            call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Undead\\\\AnimateDead\\\\AnimateDeadTarget.mdl\", GetUnitX(udg_hero[cyclA]), GetUnitY(udg_hero[cyclA]) ) )\r\n            call KillUnit( udg_hero[cyclA] )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Death takes nothing returns nothing\r\n    set gg_trg_Death = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Death, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Death, Condition( function Trig_Death_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Death, function Trig_Death_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}