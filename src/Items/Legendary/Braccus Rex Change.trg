{
  "Id": 50332752,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Braccus_Rex_Change_Conditions takes nothing returns boolean\r\n    return inv(udg_FightEnd_Unit, 'I071') > 0 or inv(udg_FightEnd_Unit, 'I072') > 0 or inv(udg_FightEnd_Unit, 'I06D') > 0 and not(udg_fightmod[3])\r\nendfunction\r\n\r\nfunction Trig_Braccus_Rex_Change_Actions takes nothing returns nothing\r\n    local unit caster = udg_FightEnd_Unit\r\n    local item it\r\n    local integer i\r\n    \r\n    set i = 0\r\n    loop\r\n        exitwhen i > 5\r\n        set it = UnitItemInSlot( caster, i)\r\n        if GetItemTypeId(it) == 'I071' then\r\n            call Inventory_ReplaceItemByNew(caster, it, 'I06D')\r\n        elseif GetItemTypeId(it) == 'I06D' then\r\n            call Inventory_ReplaceItemByNew(caster, it, 'I072')\r\n        elseif GetItemTypeId(it) == 'I072' then\r\n            call Inventory_ReplaceItemByNew(caster, it, 'I071')\r\n        endif\r\n        set i = i + 1\r\n    endloop\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", caster, \"origin\" ) )\r\n    \r\n    set it = null\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Braccus_Rex_Change takes nothing returns nothing\r\n    set gg_trg_Braccus_Rex_Change = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Braccus_Rex_Change, \"udg_FightEnd_Real\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Braccus_Rex_Change, Condition( function Trig_Braccus_Rex_Change_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Braccus_Rex_Change, function Trig_Braccus_Rex_Change_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}