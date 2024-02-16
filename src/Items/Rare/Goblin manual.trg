{
  "Id": 50332598,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Goblin_manual_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I009'\r\nendfunction\r\n\r\nfunction Trig_Goblin_manual_Actions takes nothing returns nothing\r\n    call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Orc\\\\MirrorImage\\\\MirrorImageDeathCaster.mdl\", GetManipulatingUnit(), \"origin\" ) )\r\n    if SetCount_GetPieces(GetManipulatingUnit(), SET_MECH) > 0 then\r\n        call NewUniques( GetManipulatingUnit(), 'A0XI' )\r\n    endif\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Goblin_manual takes nothing returns nothing\r\n    set gg_trg_Goblin_manual = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Goblin_manual, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Goblin_manual, Condition( function Trig_Goblin_manual_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Goblin_manual, function Trig_Goblin_manual_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}