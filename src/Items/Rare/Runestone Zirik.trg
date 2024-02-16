{
  "Id": 50332667,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Runestone_Zirik_Conditions takes nothing returns boolean\r\n    return inv(udg_FightEnd_Unit, 'I076') > 0 and UnitInventoryCount(udg_FightEnd_Unit) < 6 and udg_fightmod[3] == false\r\nendfunction\r\n\r\nfunction Trig_Runestone_Zirik_Actions takes nothing returns nothing\r\n    local integer i = GetUnitUserData(udg_FightEnd_Unit)\r\n    local item it\r\n    \r\n   set it = ItemRandomizerAll( udg_FightEnd_Unit, 0 )\r\n    if GetItemType(it) == ITEM_TYPE_ARTIFACT or GetItemType(it) == ITEM_TYPE_CAMPAIGN then\r\n        call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\ReviveHuman\\\\ReviveHuman.mdl\", udg_FightEnd_Unit, \"origin\" ) )\r\n        call statst( udg_FightEnd_Unit, 5, 5, 5, 0, true )\r\n        call textst( \"+5 stats!\", udg_FightEnd_Unit, 64, GetRandomInt( 45, 135 ), 10, 2.5 )\r\n    elseif not( udg_logic[i + 26] ) then\r\n        call statst( udg_FightEnd_Unit, -2, -2, -2, 0, true )\r\n        call textst( \"-2 stats!\", udg_FightEnd_Unit, 64, GetRandomInt( 45, 135 ), 10, 2.5 )\r\n    endif\r\n    \r\n    set it = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Runestone_Zirik takes nothing returns nothing\r\n    set gg_trg_Runestone_Zirik = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Runestone_Zirik, \"udg_FightEnd_Real\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Runestone_Zirik, Condition( function Trig_Runestone_Zirik_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Runestone_Zirik, function Trig_Runestone_Zirik_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}