{
  "Id": 50332243,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_HardModActive_Conditions takes nothing returns boolean\r\n    return GetOwningPlayer(GetEnteringUnit()) == Player(10) or GetOwningPlayer(GetEnteringUnit()) == Player(11)\r\nendfunction\r\n\r\nfunction Trig_HardModActive_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    call UnitAddAbility( GetEnteringUnit(), 'A073' )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        call UnitAddAbility( GetEnteringUnit(), udg_HardModBonus[cyclA] )\r\n        call SetUnitAbilityLevel( GetEnteringUnit(), udg_HardModBonus[cyclA], udg_HardNum)\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_HardModActive takes nothing returns nothing\r\n    set gg_trg_HardModActive = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_HardModActive )\r\n    call TriggerRegisterEnterRectSimple( gg_trg_HardModActive, GetWorldBounds() )\r\n    call TriggerAddCondition( gg_trg_HardModActive, Condition( function Trig_HardModActive_Conditions ) )\r\n    call TriggerAddAction( gg_trg_HardModActive, function Trig_HardModActive_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}