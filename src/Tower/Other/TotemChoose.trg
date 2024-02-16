{
  "Id": 50332267,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_TotemChoose_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetTriggerUnit()) == 'o013' and GetOwningPlayer(GetTriggerUnit()) == Player(PLAYER_NEUTRAL_PASSIVE)\r\nendfunction\r\n\r\nfunction Trig_TotemChoose_Actions takes nothing returns nothing\r\n    call DestroyEffect(AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Other\\\\Charm\\\\CharmTarget.mdl\", GetTriggerUnit(), \"origin\") )\r\n    call SetUnitOwner( GetTriggerUnit(), Player(4), false )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_TotemChoose takes nothing returns nothing\r\n    set gg_trg_TotemChoose = CreateTrigger(  )\r\n    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_TotemChoose, Player(0), true )\r\n    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_TotemChoose, Player(1), true )\r\n    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_TotemChoose, Player(2), true )\r\n    call TriggerRegisterPlayerSelectionEventBJ( gg_trg_TotemChoose, Player(3), true )\r\n    call TriggerAddCondition( gg_trg_TotemChoose, Condition( function Trig_TotemChoose_Conditions ) )\r\n    call TriggerAddAction( gg_trg_TotemChoose, function Trig_TotemChoose_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}